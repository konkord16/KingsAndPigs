extends AudioStreamPlayer2D

@export var min_pitch : float
@export var max_pitch : float

func _play(from_position := 0.0) -> void:
	pitch_scale = randf_range(min_pitch, max_pitch)
	play(from_position)
