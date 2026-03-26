# Between Classes — Save Server

## Setup

### 1. Install PostgreSQL
Make sure PostgreSQL is installed and running.

### 2. Create database
Open pgAdmin or psql and create the database:
```sql
CREATE DATABASE between_classes;
```

### 3. Configure .env
Edit `server/.env` with your PostgreSQL credentials:
```
DB_HOST=localhost
DB_PORT=5432
DB_NAME=between_classes
DB_USER=postgres
DB_PASSWORD=postgres
API_PORT=8080
```

### 4. Install Python dependencies
```bash
cd server
pip install -r requirements.txt
```

### 5. Run the server
```bash
python app.py
```
Or:
```bash
uvicorn app:app --port 8080
```

The server will auto-create tables `game_saves` and `game_settings` on startup.

## Viewing data in pgAdmin
1. Open pgAdmin
2. Connect to your PostgreSQL server
3. Navigate to: Databases > between_classes > Schemas > public > Tables
4. Right-click on `game_saves` or `game_settings` > View/Edit Data > All Rows

## API Endpoints
- `POST /api/save` — save game progress
- `GET /api/load?player_name=Player` — load game progress
- `GET /api/has_save?player_name=Player` — check if save exists
- `POST /api/settings` — save settings
- `GET /api/settings?player_name=Player` — load settings
