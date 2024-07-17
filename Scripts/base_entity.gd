class_name BaseEntity
extends CharacterBody2D

@export var flipped : bool # For if the asset is drawn the wrong way
const GRAVITY = 20
var grounded : bool = true
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D


func gravity():
	if not is_on_floor():
		velocity.y += GRAVITY

func animate():
	if velocity.x > 0:
		sprite.scale.x = -1 if flipped else 1
	elif velocity.x < 0:                                                        
		sprite.scale.x = -1 if not flipped else 1
		
	if not velocity:
		animation_player.play("idle")
	elif not velocity.y:
		animation_player.play("run")
	
	if not is_on_floor():
		if velocity.y < 0:
			animation_player.play("jump")
		elif velocity.y >= 0:
			animation_player.play("fall")
			
	if is_on_floor() and not grounded:
		animation_player.play("ground")	
	grounded = is_on_floor()
	
func attack():
	print("trying to attack")
	animation_player.play("attack")
	await animation_player.animation_finished
func take_damage():
	pass
