extends BaseEntity

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _physics_process(_delta):
	
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY		
	
	# Handle moving left/right
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)	
	
	if Input.is_action_just_pressed("attack"):
		print("pressed attack")
		attack()
	
		
	gravity()
	animate()
	move_and_slide()
