extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)


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
