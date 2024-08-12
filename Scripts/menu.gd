extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level0.tscn")
	Manager.set_process(true)
	
func _on_exit_pressed() -> void:
	get_tree().quit()
