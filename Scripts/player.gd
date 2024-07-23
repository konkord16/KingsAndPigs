extends BaseEntity

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var enterable_door = null

func _ready():
	hp = 100
	current_state = CUTSCENE
	if get_tree().current_scene.scene_file_path == "res://Levels/level0.tscn":
		animator.play("wake_up")
	else:
		animator.play("door_out")
	await animator.animation_finished
	current_state = MOVE

func _physics_process(_delta):
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
			
		if Input.is_action_just_pressed("up") and enterable_door and enterable_door.destination:
			enterable_door.enter()
			current_state = CUTSCENE
			velocity = Vector2.ZERO
			global_position = enterable_door.global_position
			animator.play("door_in")
	super(_delta)
	

func _on_hitbox_body_entered(body):
		if body.has_method("take_damage"):			
			body.take_damage()
