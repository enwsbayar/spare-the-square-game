extends Control


func _ready() -> void:
	$Center/VBox/ContinueButton.disabled = not GameData.has_save()
	if $Center/VBox/ContinueButton.disabled:
		$Center/VBox/ContinueButton.modulate = Color(0.4, 0.4, 0.4)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_continue_pressed() -> void:
	var lvl := GameData.continue_level()
	get_tree().change_scene_to_file("res://Scenes/Levels/level_%d.tscn" % lvl)


func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/level_select.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/settings.tscn")
