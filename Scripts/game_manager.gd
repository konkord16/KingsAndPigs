extends Node

var time := 0.0

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	time += delta

func change_music(new_music_name : String) -> void:
	var new_music : AudioStream = load("res://Sounds/" + new_music_name + ".mp3")
	if new_music != $Music.stream:
		$Music.stream = new_music
		$Music.play()
