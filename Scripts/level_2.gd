extends Node2D

@export var button_kill: Area2D
@export var button_spare: Area2D
@export var platform: StaticBody2D
@export var npc: CharacterBody2D
@export var portal: Area2D
@export var player: CharacterBody2D


func _ready() -> void:
	if button_kill:
		button_kill.pressed.connect(_on_kill)
	if button_spare:
		button_spare.pressed.connect(_on_spare)


func _on_kill() -> void:
	if button_spare:
		button_spare.deactivate()
	if platform:
		platform.start_moving()
	if npc:
		npc.died.connect(_on_npc_died, CONNECT_ONE_SHOT)


func _on_spare() -> void:
	if button_kill:
		button_kill.deactivate()
	if portal:
		portal.open_portal()


func _on_npc_died() -> void:
	if player:
		player.die()
