extends Area2D

@onready var sprite = $AnimatedSprite
var destination : int

func _ready():
	await get_tree().physics_frame
	if has_overlapping_bodies():		
		for body in get_overlapping_bodies():
			if body.is_in_group("player"):		
				sprite.play("closing")
	else:
		destination = get_tree().current_scene.scene_file_path.to_int() + 1

func enter():
	sprite.play("opening")
	await sprite.animation_finished	
	sprite.play("closing")
	await sprite.animation_finished
	sprite.play("idle")	
	get_tree().change_scene_to_file("res://Levels/level" + str(destination) + ".tscn")


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.enterable_door = self

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.enterable_door = null
