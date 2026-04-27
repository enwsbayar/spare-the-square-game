extends CharacterBody2D

enum Behavior { IDLE, CHASE, FLEE }

@export var behavior: Behavior = Behavior.IDLE
@export var player: CharacterBody2D
@export var speed: float = 100.0
@export var jump_velocity: float = -250.0
@export var chase_range: float = 200.0
@export var flee_range: float = 200.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var dead := false
var jump_played := false
var _stuck_timer := 0.0
var _last_x := 0.0


func _ready() -> void:
	_last_x = global_position.x
	dead = true
	anim.play("born")
	anim.animation_finished.connect(_on_born_finished, CONNECT_ONE_SHOT)


func _on_born_finished() -> void:
	dead = false
	anim.play("idle")


func _check_player_collision() -> void:
	if not player:
		return
	for i in get_slide_collision_count():
		if get_slide_collision(i).get_collider() == player:
			match behavior:
				Behavior.CHASE:
					player.die()
				Behavior.FLEE:
					die()
			return


func die() -> void:
	if dead:
		return
	dead = true
	velocity = Vector2.ZERO
	set_physics_process(false)
	anim.play("death")
	anim.animation_finished.connect(func(_a: StringName): queue_free(), CONNECT_ONE_SHOT)


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
				_flee(delta)
			else:
				velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	_check_player_collision()
	_update_animation()


func _chase(delta: float) -> void:
	var dir: float = sign(player.global_position.x - global_position.x)
	velocity.x = dir * speed

	if dir != 0:
		anim.flip_h = dir < 0

	if is_on_floor():
		var player_is_above: bool = player.global_position.y < global_position.y - 20.0
		if player_is_above or is_on_wall():
			velocity.y = jump_velocity

	_stuck_timer += delta
	if _stuck_timer >= 0.3:
		if abs(global_position.x - _last_x) < 2.0 and is_on_floor():
			velocity.y = jump_velocity
		_last_x = global_position.x
		_stuck_timer = 0.0


func _flee(delta: float) -> void:
	var dir: float = sign(global_position.x - player.global_position.x)
	if dir == 0:
		dir = 1.0
	velocity.x = dir * speed
	anim.flip_h = dir < 0

	if is_on_floor() and is_on_wall():
		velocity.y = jump_velocity


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
