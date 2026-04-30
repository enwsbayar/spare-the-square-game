extends Control

const FONT_PATH := "res://Fonts/PressStart2P-Regular.ttf"

const COLOR_UNLOCKED := Color(1.0, 1.0, 1.0)
const COLOR_LOCKED := Color(0.25, 0.25, 0.25)
const COLOR_HOVER := Color(0.25, 0.9, 0.35)


func _ready() -> void:
	var font := load(FONT_PATH) as FontFile
	var grid := $VBox/GridCenter/GridContainer

	for i in range(1, GameData.TOTAL_LEVELS + 1):
		var btn := Button.new()
		btn.text = "%02d" % i
		btn.flat = true
		btn.custom_minimum_size = Vector2(80, 60)
		btn.add_theme_font_override("font", font)
		btn.add_theme_font_size_override("font_size", 16)

		if GameData.is_level_unlocked(i):
			btn.add_theme_color_override("font_color", COLOR_UNLOCKED)
			btn.add_theme_color_override("font_hover_color", COLOR_HOVER)
			btn.add_theme_color_override("font_pressed_color", Color(0.2, 0.7, 0.3))
			btn.pressed.connect(_go_to_level.bind(i))
		else:
			btn.add_theme_color_override("font_color", COLOR_LOCKED)
			btn.disabled = true

		grid.add_child(btn)


func _go_to_level(level_num: int) -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_%d.tscn" % level_num)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
