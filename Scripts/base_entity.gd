class_name BaseEntity
extends CharacterBody2D


@export var flipped : bool # For if the asset is drawn the wrong way
enum {	
	MOVE,
	ATTACK,	
	DEAD,
	CUTSCENE,
}
const GRAVITY = 20
var current_state = MOVE
var grounded : bool = true
var hp : int = 3

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var particles : GPUParticles2D = $GPUParticles2D


func _physics_process(_delta):
	
	if not is_on_floor():
		velocity.y += GRAVITY
	move_and_slide()
	match current_state:
		MOVE:
			animate()
					
		ATTACK:
			velocity = Vector2.ZERO
			animator.play("attack")		
			await animator.animation_finished	
			current_state = MOVE
	
		DEAD:
			velocity = Vector2.ZERO
			animator.play("dead")
			# Add death particles, remove the body
			# Additional behaviour when a player dies
		

func animate():
	if velocity.x > 0:
		sprite.scale.x = -1 if flipped else 1
	elif velocity.x < 0:                                                        
		sprite.scale.x = 1 if flipped else -1
		
	if not velocity:
		animator.play("idle")
	elif not velocity.y and get_last_motion():
		animator.play("run")
	
	if not is_on_floor():
		if velocity.y < 0:
			animator.play("jump")
		elif velocity.y >= 0:
			animator.play("fall")
			
	if is_on_floor() and not grounded:
		animator.play("ground")	
	grounded = is_on_floor()	

	
func take_damage():
	current_state = CUTSCENE
	hp -= 1
	animator.play("hit")
	await animator.animation_finished	
	if hp <= 0:
		current_state = DEAD
	else:
		current_state = MOVE
	# Play animation, take damage,knockback, modify healthbar and die if 0 hp
