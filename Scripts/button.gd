extends Area2D

signal pressed

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var _triggered := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func deactivate() -> void:
	_triggered = true


func _on_body_entered(body: Node) -> void:
	if _triggered or not body.is_in_group("player"):
		return
	_triggered = true
	anim.play("pressed")
	pressed.emit()
