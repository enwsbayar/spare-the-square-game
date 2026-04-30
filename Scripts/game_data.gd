extends Node

const SAVE_PATH := "user://save.cfg"
const TOTAL_LEVELS := 14

var _config := ConfigFile.new()
var unlocked_levels: int = 1
var _save_exists := false


func _ready() -> void:
	_load()


func _load() -> void:
	if _config.load(SAVE_PATH) == OK:
		unlocked_levels = _config.get_value("progress", "unlocked_levels", 1)
		_save_exists = true


func save() -> void:
	_config.set_value("progress", "unlocked_levels", unlocked_levels)
	_config.save(SAVE_PATH)
	_save_exists = true


func complete_level(level_num: int) -> void:
	var next := level_num + 1
	if next > unlocked_levels and next <= TOTAL_LEVELS:
		unlocked_levels = next
	save()


func is_level_unlocked(level_num: int) -> bool:
	return level_num <= unlocked_levels


func has_save() -> bool:
	return _save_exists


func continue_level() -> int:
	return unlocked_levels
