extends AudioStreamPlayer

func change_music(new_music_name : String) -> void:
	var new_music : AudioStream = load("res://Sounds/" + new_music_name + ".mp3")
	if new_music != stream:
		stream = new_music
		play()
