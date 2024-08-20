extends VBoxContainer

func _ready() -> void:
	%Music.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(1)))
	%SFX.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(2))) 
	%Shake.set_value_no_signal(Manager.shake_multiplier)
	
func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	
func _on_sfx_value_changed(value: float, from_code := false) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	%TestSFX.play()

func _on_shake_value_changed(value: float) -> void:
	Manager.shake_multiplier = value
