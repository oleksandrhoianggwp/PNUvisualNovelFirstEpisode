class_name StatChangeCard
extends PanelContainer

@onready var stat_label: Label = %StatLabel
@onready var change_label: Label = %ChangeLabel
@onready var sigil: Label = %Sigil
@onready var accent_bar: ColorRect = $Accent


func setup(stat_name: String, _current_value: int, delta: int, custom_font: Font = null) -> void:
	stat_label.text = stat_name
	var is_reputation := stat_name == Localization.t("common.reputation")
	if is_reputation:
		change_label.text = Localization.t("game.reputation_improved" if delta > 0 else "game.reputation_worsened")
	else:
		change_label.text = Localization.t("game.relationship_improved" if delta > 0 else "game.relationship_worsened")
	var accent := Color(0.96, 0.75, 0.42, 1) if delta > 0 else Color(0.76, 0.36, 0.32, 1)
	sigil.text = "✦" if delta > 0 else "◆"
	sigil.add_theme_color_override("font_color", accent)
	change_label.add_theme_color_override("font_color", accent.lerp(Color(0.82, 0.78, 0.72, 1), 0.45))
	accent_bar.color = Color(accent.r, accent.g, accent.b, 0.4)
	var panel_style := get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	panel_style.border_color = Color(accent.r, accent.g, accent.b, 0.9)
	add_theme_stylebox_override("panel", panel_style)
	if custom_font:
		for label in [stat_label, change_label, sigil]:
			label.add_theme_font_override("font", custom_font)
