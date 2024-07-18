extends BaseEntity

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _physics_process(_delta):
	# Taking input
	if current_state == MOVE:		
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = 0
		
		if Input.is_action_just_pressed("attack") and is_on_floor():
			current_state = ATTACK
			
	super(_delta)
