extends Area2D

enum MoveDirection { NONE, HORIZONTAL, VERTICAL }
enum MoveStyle { BOUNCE, LOOP }

@export var rotation_speed := 21.0
@export var move_direction: MoveDirection = MoveDirection.NONE
@export var move_style: MoveStyle = MoveStyle.BOUNCE
@export var move_speed: float = 60.0
@export var move_range: float = 80.0

var _start_position: Vector2
var _time := 0.0


func _ready() -> void:
	_start_position = position
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	rotation += rotation_speed * delta

	if move_direction == MoveDirection.NONE:
		return

	_time += delta
	var offset: float
	if move_style == MoveStyle.BOUNCE:
		offset = sin(_time * move_speed * 0.05) * move_range
	else:
		offset = fmod(_time * move_speed, move_range * 2.0) - move_range

	if move_direction == MoveDirection.HORIZONTAL:
		position = _start_position + Vector2(offset, 0)
	else:
		position = _start_position + Vector2(0, offset)


func _on_body_entered(body: Node) -> void:
	if not body is CharacterBody2D:
		queue_free()
		return
	body.die()
