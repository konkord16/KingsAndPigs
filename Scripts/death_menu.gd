extends Control

func _on_exit_pressed() -> void: 
	get_tree().change_scene_to_file("res://Levels/menu.tscn")
	reset()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	reset()

func reset() -> void:
	Player.bombs = 0
	Player.diamonds = 0
	Player.overall_diamonds = 0
	Manager.change_music("medieval_music")
