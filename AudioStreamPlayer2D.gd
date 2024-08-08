extends AudioStreamPlayer2D

func _play(from_position := 0.0) -> void:
	pitch_scale = randf_range(0.9, 1.1)
	play(from_position)
