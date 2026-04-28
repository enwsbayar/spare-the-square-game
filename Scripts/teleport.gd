extends Area2D

@export var teleport_id: String = "A"

var _cooldown := false


func _ready() -> void:
	add_to_group("teleport")
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if _cooldown or not body.is_in_group("player"):
		return
	for node in get_tree().get_nodes_in_group("teleport"):
		if node != self and node.teleport_id == teleport_id:
			_do_teleport(body, node)
			return


func _do_teleport(body: Node, destination: Node) -> void:
	_cooldown = true
	destination._cooldown = true
	body.global_position = destination.global_position
	await get_tree().create_timer(0.5).timeout
	_cooldown = false
	if is_instance_valid(destination):
		destination._cooldown = false
