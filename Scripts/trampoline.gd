extends StaticBody2D

@export var bounce_force: float = -500.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	add_to_group("trampoline")


func bounce() -> void:
	if anim.is_playing() and anim.animation == &"bounce":
		return
	anim.play("bounce")
	anim.animation_finished.connect(_on_bounce_finished, CONNECT_ONE_SHOT)


func _on_bounce_finished() -> void:
	anim.play("idle")
