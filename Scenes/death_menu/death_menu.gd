extends Control

func _on_to_menu_pressed() -> void: 
	get_tree().change_scene_to_file("res://Levels/level0.tscn")
	Player.bombs = 0
	Player.diamonds = 0
	Player.overall_diamonds = 0
	Manager.overall_diamonds = 0
	Manager.bombs = 0
	Manager.current_diamonds = 0
	Manager.change_music("medieval_music")

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	Player.overall_diamonds = Manager.overall_diamonds
	Player.bombs = Manager.bombs
	Player.diamonds = Manager.current_diamonds
	Manager.change_music("medieval_music")
