extends CharacterBody2D

@export var speed: float = 100.0
@export var jump_velocity: float = -250.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var spawn_point: Marker2D

var dead := false
var jump_played := false
var respawn := true


func _ready() -> void:
	born()


func _physics_process(delta: float) -> void:
	if dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * speed
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if Input.is_action_just_pressed("death"):
		die()

	if Input.is_action_just_pressed("born"):
		born()

	move_and_slide()
	_update_animation()


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



func die() -> void:
	if dead:
		return
	dead = true
	velocity = Vector2.ZERO
	anim.play("death")
	anim.animation_finished.connect(_on_death_animation_finished, CONNECT_ONE_SHOT)


func _on_death_animation_finished() -> void:
	if respawn:
		get_tree().reload_current_scene()


func born() -> void:
	dead = true
	jump_played = false
	velocity = Vector2.ZERO
	_teleport_to_spawn()
	anim.play("born")
	anim.animation_finished.connect(_on_born_finished, CONNECT_ONE_SHOT)


func _on_born_finished() -> void:
	dead = false
	anim.play("idle")


func _teleport_to_spawn() -> void:
	if spawn_point:
		global_position = spawn_point.global_position
