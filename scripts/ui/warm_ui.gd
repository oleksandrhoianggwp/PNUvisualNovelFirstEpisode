class_name WarmUI
extends RefCounted

const INK := Color("#35271F")
const INK_SOFT := Color("#59483D")
const CREAM := Color("#FFF4DE")
const PAPER := Color("#F5E7CC")
const TERRACOTTA := Color("#B95F43")
const TERRACOTTA_DARK := Color("#874532")
const SAGE := Color("#55715F")
const GOLD := Color("#D6A55C")


static func panel_style(alpha: float = 0.94, radius: int = 22, shadow: bool = true) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(CREAM.r, CREAM.g, CREAM.b, alpha)
	style.border_color = Color(0.58, 0.39, 0.27, 0.28)
	style.set_border_width_all(1)
	style.set_corner_radius_all(radius)
	if shadow:
		style.shadow_color = Color(0.12, 0.07, 0.04, 0.24)
		style.shadow_size = 18
		style.shadow_offset = Vector2(0, 7)
	return style


static func dark_glass_style(alpha: float = 0.9, radius: int = 20) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.12, 0.075, 0.055, alpha)
	style.border_color = Color(0.95, 0.76, 0.49, 0.5)
	style.set_border_width_all(1)
	style.set_corner_radius_all(radius)
	style.shadow_color = Color(0.04, 0.025, 0.02, 0.32)
	style.shadow_size = 16
	style.shadow_offset = Vector2(0, 6)
	return style


static func style_button(button: Button, primary: bool = false, font_size: int = 20) -> void:
	button.add_theme_font_size_override("font_size", font_size)
	button.add_theme_color_override("font_color", CREAM if primary else INK)
	button.add_theme_color_override("font_hover_color", Color.WHITE if primary else TERRACOTTA_DARK)
	button.add_theme_color_override("font_pressed_color", CREAM if primary else TERRACOTTA_DARK)
	button.add_theme_color_override("font_disabled_color", Color(INK.r, INK.g, INK.b, 0.38))
	button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	var normal := StyleBoxFlat.new()
	normal.bg_color = TERRACOTTA if primary else Color(1.0, 0.965, 0.88, 0.78)
	normal.border_color = Color(TERRACOTTA_DARK.r, TERRACOTTA_DARK.g, TERRACOTTA_DARK.b, 0.48)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(14)
	normal.set_content_margin_all(13)
	button.add_theme_stylebox_override("normal", normal)

	var hover := normal.duplicate() as StyleBoxFlat
	hover.bg_color = Color("#C96C4E") if primary else Color("#FFF8E9")
	hover.border_color = GOLD if primary else TERRACOTTA
	hover.set_border_width_all(2)
	button.add_theme_stylebox_override("hover", hover)

	var pressed := normal.duplicate() as StyleBoxFlat
	pressed.bg_color = TERRACOTTA_DARK if primary else PAPER
	pressed.border_color = TERRACOTTA_DARK
	pressed.set_border_width_all(2)
	button.add_theme_stylebox_override("pressed", pressed)

	var disabled := normal.duplicate() as StyleBoxFlat
	disabled.bg_color = Color(0.84, 0.79, 0.7, 0.38)
	disabled.border_color = Color(0.45, 0.36, 0.29, 0.2)
	button.add_theme_stylebox_override("disabled", disabled)

	if not button.has_meta("warm_hover_connected"):
		button.set_meta("warm_hover_connected", true)
		button.mouse_entered.connect(func(): _tween_scale(button, Vector2(1.018, 1.018), 0.14))
		button.mouse_exited.connect(func(): _tween_scale(button, Vector2.ONE, 0.18))
		button.focus_entered.connect(func(): _tween_scale(button, Vector2(1.018, 1.018), 0.14))
		button.focus_exited.connect(func(): _tween_scale(button, Vector2.ONE, 0.18))
		button.resized.connect(func(): button.pivot_offset = button.size * 0.5)
	button.pivot_offset = button.size * 0.5


static func style_option(option: OptionButton) -> void:
	option.add_theme_font_size_override("font_size", 16)
	option.add_theme_color_override("font_color", INK)
	option.add_theme_color_override("font_hover_color", TERRACOTTA_DARK)
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(1, 0.98, 0.92, 0.86)
	normal.border_color = Color(TERRACOTTA_DARK.r, TERRACOTTA_DARK.g, TERRACOTTA_DARK.b, 0.34)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(11)
	normal.set_content_margin_all(10)
	option.add_theme_stylebox_override("normal", normal)
	var hover := normal.duplicate() as StyleBoxFlat
	hover.bg_color = Color.WHITE
	hover.border_color = TERRACOTTA
	hover.set_border_width_all(2)
	option.add_theme_stylebox_override("hover", hover)


static func style_slider(slider: HSlider) -> void:
	slider.custom_minimum_size.y = 28
	var track := StyleBoxFlat.new()
	track.bg_color = Color(0.32, 0.24, 0.19, 0.17)
	track.set_corner_radius_all(5)
	track.set_content_margin_all(4)
	slider.add_theme_stylebox_override("slider", track)
	var fill := StyleBoxFlat.new()
	fill.bg_color = TERRACOTTA
	fill.set_corner_radius_all(5)
	fill.set_content_margin_all(4)
	slider.add_theme_stylebox_override("grabber_area", fill)
	var fill_hover := fill.duplicate() as StyleBoxFlat
	fill_hover.bg_color = Color("#CE775B")
	slider.add_theme_stylebox_override("grabber_area_highlight", fill_hover)


static func animate_in(control: Control, delay: float = 0.0, duration: float = 0.4, start_scale: float = 0.975) -> void:
	control.modulate.a = 0.0
	control.scale = Vector2(start_scale, start_scale)
	control.pivot_offset = control.size * 0.5
	var tween := control.create_tween()
	tween.tween_interval(delay)
	tween.tween_property(control, "modulate:a", 1.0, duration).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(control, "scale", Vector2.ONE, duration + 0.08).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


static func _tween_scale(control: Control, target: Vector2, duration: float) -> void:
	if not is_instance_valid(control):
		return
	if control is BaseButton and (control as BaseButton).disabled:
		return
	if control.has_meta("warm_hover_tween"):
		var previous = control.get_meta("warm_hover_tween")
		if previous is Tween and previous.is_valid():
			previous.kill()
	var tween := control.create_tween()
	control.set_meta("warm_hover_tween", tween)
	tween.tween_property(control, "scale", target, duration).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
