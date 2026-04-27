extends Node2D

@export var portal: Area2D

@export var label_a: Label
@export var label_d: Label
@export var label_space: Label

var _pressed := {&"a": false, &"d": false, &"space": false}

const COLOR_OFF := Color(0.15, 0.15, 0.15)
const COLOR_ON := Color(0.25, 0.9, 0.35)


func _process(_delta: float) -> void:
	_check(&"a", "walk_left", label_a)
	_check(&"d", "walk_right", label_d)
	_check(&"space", "jump", label_space)


func _check(key: StringName, action: String, label: Label) -> void:
	if _pressed[key]:
		return
	if Input.is_action_just_pressed(action):
		_pressed[key] = true
		if label:
			label.add_theme_color_override("font_color", COLOR_ON)
		_try_open_portal()


func _try_open_portal() -> void:
	if _pressed[&"a"] and _pressed[&"d"] and _pressed[&"space"]:
		portal.open_portal()
