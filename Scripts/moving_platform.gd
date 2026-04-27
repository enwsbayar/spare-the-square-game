extends StaticBody2D

@export var move_direction: Vector2 = Vector2.RIGHT
@export var move_speed: float = 60.0
@export var move_duration: float = 2.0

var _moving := false
var _timer := 0.0


func start_moving() -> void:
	_moving = true


func _process(delta: float) -> void:
	if not _moving:
		return
	_timer += delta
	if _timer >= move_duration:
		queue_free()
		return
	position += move_direction.normalized() * move_speed * delta
