extends BaseEntity

var enterable_door = null
const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _physics_process(_delta):
	print(enterable_door)
	# Taking input
	if current_state == MOVE:		
		if is_on_floor():
			if Input.is_action_pressed("jump"):
				velocity.y = JUMP_VELOCITY
			elif Input.is_action_pressed("down"):
				global_position.y += 1

		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = 0
		
		if Input.is_action_just_pressed("attack") and is_on_floor():
			current_state = ATTACK
			
		if Input.is_action_just_pressed("up") and enterable_door:
			enterable_door.enter()
			current_state = CUTSCENE
			velocity = Vector2.ZERO
			global_position = enterable_door.global_position
			animation_player.play("door_in")
	super(_delta)
