extends VBoxContainer

func _ready() -> void:
	%Music.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	%SFX.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	%Shake.value = Manager.shake_multiplier
	
func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	print(linear_to_db(value))

func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	print("changed")
	print(%TestSFX.global_position)
	%TestSFX.play()

func _on_shake_value_changed(value: float) -> void:
	Manager.shake_multiplier = value
