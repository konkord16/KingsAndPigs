extends Control

func _on_exit_pressed() -> void: 
	get_tree().change_scene_to_file("res://Levels/menu.tscn")
	Player.bombs = 0
	Player.diamonds = 0
	Music.change_music("medieval_music")
func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level0.tscn")
	Player.bombs = 0
	Player.diamonds = 0
	Music.change_music("medieval_music")
