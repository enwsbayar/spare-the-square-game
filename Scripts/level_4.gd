extends Node2D

@export var npcs: Array[CharacterBody2D]
@export var portal: Area2D

var _remaining := 0


func _ready() -> void:
	_remaining = npcs.size()
	for npc in npcs:
		npc.died.connect(_on_npc_died)


func _on_npc_died() -> void:
	_remaining -= 1
	if _remaining <= 0:
		portal.open_portal()
