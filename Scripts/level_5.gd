extends Node2D

@export var button: Area2D
@export var platform: StaticBody2D
@export var npc: CharacterBody2D
@export var portal: Area2D


func _ready() -> void:
	if button:
		button.pressed.connect(_on_button_pressed, CONNECT_ONE_SHOT)
	if npc:
		npc.died.connect(func(): portal.open_portal(), CONNECT_ONE_SHOT)


func _on_button_pressed() -> void:
	if platform:
		platform.start_moving()
