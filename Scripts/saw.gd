extends Area2D

@export var rotation_speed := 21.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node) -> void:
	if not body is CharacterBody2D:
		return
	body.die()
