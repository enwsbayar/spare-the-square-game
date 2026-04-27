extends Area2D

enum MoveDirection { LEFT, RIGHT, UP, DOWN }

@export var move_direction: MoveDirection = MoveDirection.RIGHT
@export var move_speed: float = 120.0
@export var rotation_speed: float = 21.0

var _dir_vector: Vector2


func _ready() -> void:
	match move_direction:
		MoveDirection.LEFT:  _dir_vector = Vector2.LEFT
		MoveDirection.RIGHT: _dir_vector = Vector2.RIGHT
		MoveDirection.UP:    _dir_vector = Vector2.UP
		MoveDirection.DOWN:  _dir_vector = Vector2.DOWN
	body_entered.connect(_on_body_entered)


func _set_direction(dir: Vector2) -> void:
	_dir_vector = dir.normalized()


func _process(delta: float) -> void:
	rotation += rotation_speed * delta
	position += _dir_vector * move_speed * delta


func _on_body_entered(body: Node) -> void:
	if not body is CharacterBody2D:
		queue_free()
		return
	body.die()
	queue_free()
