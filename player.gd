extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var jumping = false

@onready var animated_sprite = $Node2D/AnimatedSprite2D

@onready var node_2d = $Node2D



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumping = true

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction == 0:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("run")

		
	if direction > 0:
		node_2d.scale.x = 1
	if direction < 0:                                                        
		node_2d.scale.x = -1
		
		
	if velocity.y > 0:
		animated_sprite.play("fall")
	elif velocity.y < 0:
		animated_sprite.play("jump")
		
	if jumping == true and is_on_floor():
		animated_sprite.play("ground")
		jumping = false

	move_and_slide()
