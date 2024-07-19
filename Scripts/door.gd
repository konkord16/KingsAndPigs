extends Area2D

@onready var sprite = $AnimatedSprite
@export var destination : String
@export_enum("open", "closed") var init_state

func _ready():
	if init_state == 0:		
		sprite.play("closing")

func enter():
	sprite.play("opening")
	await sprite.animation_finished	
	sprite.play("closing")
	await sprite.animation_finished
	sprite.play("idle")	
	get_tree().change_scene_to_file("res://Levels/" + destination + ".tscn")


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.enterable_door = self


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.enterable_door = null
