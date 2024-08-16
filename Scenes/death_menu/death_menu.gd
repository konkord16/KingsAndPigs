extends Control

func _on_exit_pressed() -> void: 
	get_tree().change_scene_to_file("res://Scenes/menu/menu.tscn")
	Player.bombs = 0
	Player.diamonds = 0
	Player.overall_diamonds = 0
	Manager.change_music("medieval_music")

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	Player.overall_diamonds = Manager.overall_diamonds
	Player.bombs = Manager.bombs
	Player.diamonds = Manager.current_diamonds
	Manager.change_music("medieval_music")
