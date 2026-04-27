extends Node2D

@export var projectile_scene: PackedScene
@export var fire_interval: float = 2.0
@export var fire_direction: Vector2 = Vector2.RIGHT

var _timer := 0.0


func _process(delta: float) -> void:
	_timer += delta
	if _timer >= fire_interval:
		_timer = 0.0
		_fire()


func _fire() -> void:
	if not projectile_scene:
		return

	var projectile := projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = global_position

	if projectile.has_method("_set_direction"):
		projectile._set_direction(fire_direction)
	elif "move_direction" in projectile:
		_apply_direction(projectile)


func _apply_direction(projectile: Node) -> void:
	var d := fire_direction.normalized()
	if absf(d.x) >= absf(d.y):
		projectile.move_direction = 1 if d.x >= 0 else 0
	else:
		projectile.move_direction = 3 if d.y >= 0 else 2
