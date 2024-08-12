extends Control

func _on_exit_pressed() -> void: 
	get_tree().change_scene_to_file("res://Levels/menu.tscn")
	reset()

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level0.tscn")
	reset()
	Manager.set_process(true)

func reset() -> void:
	Player.bombs = 0
	Player.diamonds = 0
	Player.overall_diamonds = 0
	Manager.time = 0
	Manager.set_process(false)
	Manager.change_music("medieval_music")
