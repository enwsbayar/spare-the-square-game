extends Node2D

@export var npc_1: CharacterBody2D
@export var npc_2: CharacterBody2D
@export var npc_3: CharacterBody2D
@export var platform_1: StaticBody2D
@export var platform_2: StaticBody2D
@export var platform_3: StaticBody2D
@export var button: Area2D
@export var portal: Area2D

func _ready() -> void:
	if button:
		button.pressed.connect(_on_button_pressed, CONNECT_ONE_SHOT)
	if npc_1:
		npc_1.died.connect(_on_npc_1_died, CONNECT_ONE_SHOT)
	if npc_2:
		npc_2.died.connect(_on_npc_2_died, CONNECT_ONE_SHOT)
	if npc_3:
		npc_3.died.connect(func(): portal.open_portal(), CONNECT_ONE_SHOT)


func _on_npc_1_died() -> void:
	if platform_1:
		platform_1.start_moving()

func _on_npc_2_died() -> void:
	if platform_2:
		platform_2.start_moving()


func _on_button_pressed() -> void:
	if platform_3:
		platform_3.start_moving()