extends Area2D

func _on_body_entered(body: Node2D) -> void:
	get_tree().get_first_node_in_group("player").ui.position.x = 750
	$Camera2D.make_current()
