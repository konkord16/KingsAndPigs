extends TileMap

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var tween = create_tween()
		tween.tween_property(self, "modulate",Color(1,1,1,0), 0.25)


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		var tween = create_tween()
		tween.tween_property(self, "modulate",Color(1,1,1,1), 0.25)
