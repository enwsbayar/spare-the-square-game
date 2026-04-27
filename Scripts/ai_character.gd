extends CharacterBody2D

signal died

enum Behavior { IDLE, CHASE, FLEE, STARE }

@export var behavior: Behavior = Behavior.IDLE
@export var player: CharacterBody2D
@export var speed: float = 100.0
@export var jump_velocity: float = -250.0
@export var chase_range: float = 200.0
@export var flee_range: float = 200.0
@export var stare_freeze_duration: float = 1.5

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var dead := false
var jump_played := false
var _freeze_timer := 0.0
var _stuck_timer := 0.0
var _last_x := 0.0


func _ready() -> void:
	dead = true
	_last_x = global_position.x
	anim.play("born")
	anim.animation_finished.connect(_on_born_finished, CONNECT_ONE_SHOT)


func _on_born_finished() -> void:
	dead = false
	anim.play("idle")


func die() -> void:
	if dead:
		return
	dead = true
	died.emit()
	velocity = Vector2.ZERO
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	anim.play("death")
	anim.frame_changed.connect(func():
		if anim.frame >= anim.sprite_frames.get_frame_count("death") - 1:
			modulate.a = 0.0
			queue_free()
	)


func _physics_process(delta: float) -> void:
	if dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	var dist: float = global_position.distance_to(player.global_position) if player else INF

	match behavior:
		Behavior.IDLE:
			velocity.x = move_toward(velocity.x, 0, speed)
		Behavior.CHASE:
			if dist <= chase_range:
				_chase(delta)
			else:
				velocity.x = move_toward(velocity.x, 0, speed)
		Behavior.FLEE:
			if dist <= flee_range:
				_flee()
			else:
				velocity.x = move_toward(velocity.x, 0, speed)
		Behavior.STARE:
			if _player_is_watching():
				_freeze_timer = stare_freeze_duration
				velocity.x = move_toward(velocity.x, 0, speed)
			elif _freeze_timer > 0.0:
				_freeze_timer -= delta
				velocity.x = move_toward(velocity.x, 0, speed)
			else:
				_chase(delta)

	move_and_slide()
	_check_player_collision()
	_update_animation()


func _chase(delta: float) -> void:
	var dir: float = sign(player.global_position.x - global_position.x)
	velocity.x = dir * speed
	if dir != 0:
		anim.flip_h = dir < 0

	var player_above := player.global_position.y < global_position.y - 16.0
	var player_below := player.global_position.y > global_position.y + 8.0

	if is_on_floor() and player_above:
		velocity.y = jump_velocity
		return

	if is_on_wall() and not player_below:
		velocity.y = jump_velocity

	_stuck_timer += delta
	if _stuck_timer >= 0.25:
		if abs(global_position.x - _last_x) < 1.0 and is_on_floor() and not player_below:
			velocity.y = jump_velocity
		_last_x = global_position.x
		_stuck_timer = 0.0


func _flee() -> void:
	var dir: float = sign(global_position.x - player.global_position.x)
	if dir == 0:
		dir = 1.0
	velocity.x = dir * speed
	anim.flip_h = dir < 0
	if is_on_floor() and is_on_wall():
		velocity.y = jump_velocity


func _player_is_watching() -> bool:
	var dir_to_me: float = sign(global_position.x - player.global_position.x)
	return dir_to_me == player.facing


func _check_player_collision() -> void:
	if not player or dead:
		return

	var touching := false
	for i in get_slide_collision_count():
		if get_slide_collision(i).get_collider() == player:
			touching = true
			break
	if not touching:
		touching = global_position.distance_to(player.global_position) < 16.0

	if touching:
		match behavior:
			Behavior.CHASE, Behavior.STARE:
				player.die()
			Behavior.FLEE:
				die()


func _update_animation() -> void:
	if dead:
		return
	if not is_on_floor():
		if not jump_played:
			jump_played = true
			anim.play("jump")
	else:
		jump_played = false
		if anim.animation != "idle":
			anim.play("idle")
