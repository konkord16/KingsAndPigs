extends AudioStreamPlayer

var shake_strength := 0.0
var shake_fade := 0.3
var time := 0.0
var hp := 3 # To save stuff when resetting to checkpoint
var bombs := 0
var current_diamonds := 0
var overall_diamonds := 0

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	time += delta

func _physics_process(delta: float) -> void:
	if shake_strength > 0: # Shaking the camera 
		shake_strength = lerpf(shake_strength, 0, shake_fade)
		if shake_strength < 1:
			shake_strength = 0
		var offset := Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
		get_viewport().get_camera_2d().offset = offset

func change_music(new_music_name : String) -> void:
	var new_music : AudioStream = load("res://Sounds/" + new_music_name + ".mp3")
	if new_music != stream:
		stream = new_music
		play()
