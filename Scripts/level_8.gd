extends Node2D

@export var button_accept: Area2D
@export var button_refuse: Area2D
@export var npc: CharacterBody2D
@export var portal: Area2D
@export var platform_refuse: StaticBody2D
@export var platform_accept: StaticBody2D

func _ready() -> void:
	if button_accept:
		button_accept.pressed.connect(_on_accept)
	if button_refuse:
		button_refuse.pressed.connect(_on_refuse)
	if npc:
		npc.died.connect(func(): portal.open_portal(), CONNECT_ONE_SHOT)

func _on_accept() -> void:
	if button_refuse:
		button_refuse.deactivate()
	if platform_accept:
		platform_accept.start_moving()

func _on_refuse() -> void:
	if button_accept:
		button_accept.deactivate()
	if platform_refuse:
		platform_refuse.start_moving()
