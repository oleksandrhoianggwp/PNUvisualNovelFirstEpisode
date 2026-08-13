class_name StatChangeCard
extends PanelContainer

@onready var stat_label: Label = %StatLabel
@onready var value_label: Label = %ValueLabel
@onready var delta_label: Label = %DeltaLabel


func setup(stat_name: String, current_value: int, delta: int, custom_font: Font = null) -> void:
	stat_label.text = stat_name
	value_label.text = str(current_value)
	delta_label.text = ("+" if delta > 0 else "") + str(delta)
	delta_label.add_theme_color_override(
		"font_color",
		Color(0.35, 0.82, 0.5, 1) if delta > 0 else Color(0.95, 0.42, 0.4, 1)
	)
	if custom_font:
		for label in [stat_label, value_label, delta_label]:
			label.add_theme_font_override("font", custom_font)
