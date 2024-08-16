extends Area2D

@export var enterable := true
var destination : int
@onready var sprite : AnimatedSprite2D= $AnimatedSprite

func _ready() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame	
	if has_overlapping_bodies():		
		for body in get_overlapping_bodies():
			if body.is_in_group("player"):		
				sprite.play("closing")
	else:
		destination = get_tree().current_scene.scene_file_path.to_int() + 1


func enter() -> void:
	sprite.play("opening")
	await sprite.animation_finished	
	sprite.play("closing")
	await sprite.animation_finished
	sprite.play("idle")	
	get_tree().change_scene_to_file("res://Levels/level" + str(destination) + ".tscn")


func _on_body_entered(body : Node2D) -> void:
	if body.is_in_group("player"):
		body.enterable_door = self


func _on_body_exited(body : Node2D) -> void:
	if body.is_in_group("player"):
		body.enterable_door = null
