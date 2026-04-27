extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var _is_open := false


func _ready() -> void:
	collision.disabled = true
	sprite.modulate = Color(1.0, 1.0, 1.0, 0.0)
	sprite.scale = Vector2(0.0, 0.0)
	body_entered.connect(_on_body_entered)


func open_portal() -> void:
	if _is_open:
		return
	_is_open = true

	var tween := create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "scale", Vector2(1.0, 1.0), 0.6)
	tween.parallel().tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.4)
	tween.tween_callback(func(): collision.disabled = false)


func _on_body_entered(body: Node) -> void:
	if not body is CharacterBody2D:
		return

	var current := get_tree().current_scene.scene_file_path
	var file_name := current.get_file().get_basename()
	var parts := file_name.split("_")
	var next_num := int(parts[-1]) + 1
	var next_scene := "res://Scenes/Levels/level_%d.tscn" % next_num

	if not ResourceLoader.exists(next_scene):
		return

	body.respawn = false
	body.die()
	body.anim.animation_finished.connect(
		func(): get_tree().change_scene_to_file(next_scene),
		CONNECT_ONE_SHOT
	)
