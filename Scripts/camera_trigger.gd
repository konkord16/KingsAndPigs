extends Area2D

func _on_body_entered(body: Node2D) -> void:
	$Camera2D.make_current()


func _on_body_exited(body: Node2D) -> void:
	body.camera.make_current()
