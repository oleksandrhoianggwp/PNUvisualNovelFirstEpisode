import os
import json
from datetime import datetime
from contextlib import contextmanager

from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import psycopg2
from psycopg2.extras import RealDictCursor

load_dotenv()

app = FastAPI(title="Between Classes - Save Server")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "port": int(os.getenv("DB_PORT", "5432")),
    "dbname": os.getenv("DB_NAME", "between_classes"),
    "user": os.getenv("DB_USER", "postgres"),
    "password": os.getenv("DB_PASSWORD", "postgres"),
}


@contextmanager
def get_conn():
    conn = psycopg2.connect(**DB_CONFIG, cursor_factory=RealDictCursor)
    try:
        yield conn
    finally:
        conn.close()


def init_db():
    with get_conn() as conn:
        cur = conn.cursor()
        cur.execute("""
            CREATE TABLE IF NOT EXISTS game_saves (
                id SERIAL PRIMARY KEY,
                player_name VARCHAR(100) NOT NULL DEFAULT 'Player' UNIQUE,
                dialogue_index INTEGER NOT NULL DEFAULT 0,
                chapter INTEGER NOT NULL DEFAULT 1,
                choices_made JSONB NOT NULL DEFAULT '{}',
                created_at TIMESTAMP NOT NULL DEFAULT NOW(),
                updated_at TIMESTAMP NOT NULL DEFAULT NOW()
            );
        """)
        cur.execute("""
            CREATE TABLE IF NOT EXISTS game_settings (
                id SERIAL PRIMARY KEY,
                player_name VARCHAR(100) NOT NULL DEFAULT 'Player' UNIQUE,
                music_volume REAL NOT NULL DEFAULT 0.8,
                sfx_volume REAL NOT NULL DEFAULT 0.8,
                text_speed REAL NOT NULL DEFAULT 0.03,
                fullscreen BOOLEAN NOT NULL DEFAULT FALSE,
                updated_at TIMESTAMP NOT NULL DEFAULT NOW()
            );
        """)
        conn.commit()
        cur.close()


@app.on_event("startup")
def startup():
    try:
        init_db()
        print("Database initialized successfully")
    except Exception as e:
        print(f"Warning: Could not initialize database: {e}")
        print("Make sure PostgreSQL is running and the database 'between_classes' exists.")
        print("Create it with: CREATE DATABASE between_classes;")


# --- Models ---

class SaveData(BaseModel):
    player_name: str = "Player"
    dialogue_index: int = 0
    chapter: int = 1
    choices_made: dict = {}


class SettingsData(BaseModel):
    player_name: str = "Player"
    music_volume: float = 0.8
    sfx_volume: float = 0.8
    text_speed: float = 0.03
    fullscreen: bool = False


# --- Save endpoints ---

@app.post("/api/save")
def save_game(data: SaveData):
    try:
        with get_conn() as conn:
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO game_saves (player_name, dialogue_index, chapter, choices_made, updated_at)
                VALUES (%s, %s, %s, %s, %s)
                ON CONFLICT (player_name) DO UPDATE SET
                    dialogue_index = EXCLUDED.dialogue_index,
                    chapter = EXCLUDED.chapter,
                    choices_made = EXCLUDED.choices_made,
                    updated_at = EXCLUDED.updated_at
                RETURNING id;
            """, (data.player_name, data.dialogue_index, data.chapter,
                  json.dumps(data.choices_made), datetime.now()))
            result = cur.fetchone()
            conn.commit()
            cur.close()
            return {"status": "ok", "id": result["id"] if result else None}
    except psycopg2.OperationalError as e:
        raise HTTPException(status_code=503, detail=f"Database unavailable: {e}")


@app.get("/api/load")
def load_game(player_name: str = "Player"):
    try:
        with get_conn() as conn:
            cur = conn.cursor()
            cur.execute("""
                SELECT dialogue_index, chapter, choices_made, updated_at
                FROM game_saves
                WHERE player_name = %s
                ORDER BY updated_at DESC
                LIMIT 1;
            """, (player_name,))
            row = cur.fetchone()
            cur.close()
            if not row:
                raise HTTPException(status_code=404, detail="No save found")
            return {
                "dialogue_index": row["dialogue_index"],
                "chapter": row["chapter"],
                "choices_made": row["choices_made"],
                "updated_at": str(row["updated_at"]),
            }
    except psycopg2.OperationalError as e:
        raise HTTPException(status_code=503, detail=f"Database unavailable: {e}")


@app.get("/api/has_save")
def has_save(player_name: str = "Player"):
    try:
        with get_conn() as conn:
            cur = conn.cursor()
            cur.execute("SELECT COUNT(*) as cnt FROM game_saves WHERE player_name = %s;", (player_name,))
            row = cur.fetchone()
            cur.close()
            return {"has_save": row["cnt"] > 0}
    except psycopg2.OperationalError:
        return {"has_save": False}


# --- Settings endpoints ---

@app.post("/api/settings")
def save_settings(data: SettingsData):
    try:
        with get_conn() as conn:
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO game_settings (player_name, music_volume, sfx_volume, text_speed, fullscreen, updated_at)
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (player_name) DO UPDATE SET
                    music_volume = EXCLUDED.music_volume,
                    sfx_volume = EXCLUDED.sfx_volume,
                    text_speed = EXCLUDED.text_speed,
                    fullscreen = EXCLUDED.fullscreen,
                    updated_at = EXCLUDED.updated_at
                RETURNING id;
            """, (data.player_name, data.music_volume, data.sfx_volume,
                  data.text_speed, data.fullscreen, datetime.now()))
            result = cur.fetchone()
            conn.commit()
            cur.close()
            return {"status": "ok", "id": result["id"] if result else None}
    except psycopg2.OperationalError as e:
        raise HTTPException(status_code=503, detail=f"Database unavailable: {e}")


@app.get("/api/settings")
def load_settings(player_name: str = "Player"):
    try:
        with get_conn() as conn:
            cur = conn.cursor()
            cur.execute("""
                SELECT music_volume, sfx_volume, text_speed, fullscreen
                FROM game_settings
                WHERE player_name = %s
                ORDER BY updated_at DESC
                LIMIT 1;
            """, (player_name,))
            row = cur.fetchone()
            cur.close()
            if not row:
                return {
                    "music_volume": 0.8,
                    "sfx_volume": 0.8,
                    "text_speed": 0.03,
                    "fullscreen": False,
                }
            return dict(row)
    except psycopg2.OperationalError:
        return {
            "music_volume": 0.8,
            "sfx_volume": 0.8,
            "text_speed": 0.03,
            "fullscreen": False,
        }


@app.get("/api/health")
def health():
    try:
        with get_conn() as conn:
            cur = conn.cursor()
            cur.execute("SELECT 1;")
            cur.close()
            return {"status": "ok", "database": "connected"}
    except psycopg2.OperationalError:
        return {"status": "ok", "database": "disconnected"}


if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("API_PORT", "8080"))
    uvicorn.run(app, host="0.0.0.0", port=port)
