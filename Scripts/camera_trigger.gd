extends Area2D

func _on_body_entered(body: Node2D) -> void:
	$Camera2D.make_current()
