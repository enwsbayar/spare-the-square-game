extends Node2D

@export var portal: Area2D


func _ready() -> void:
	if portal:
		portal.open_portal()
