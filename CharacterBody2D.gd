extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 20
var grounded : bool = true
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite = $Pivot/AnimatedSprite2D

func _physics_process(_delta):	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY		
	
	# Handle moving left/right
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)	
	
	# Handle animations
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
		
	if direction > 0:
		$Pivot.scale.x = 1
	elif direction < 0:                                                        
		$Pivot.scale.x = -1		
		
	if velocity.y > 0:
		animated_sprite.play("fall")
	elif velocity.y < 0:
		animated_sprite.play("jump")
	
	if is_on_floor() and not grounded:
		animated_sprite.play("ground")			
	grounded = is_on_floor()
	
	move_and_slide()
