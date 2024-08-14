extends BaseEntity

const JUMP_VELOCITY = -500.0
const MOVE_SPEED = 50.0
<<<<<<< Updated upstream

var player : Player
var direction : int
=======
>>>>>>> Stashed changes
var jumping_destination : float

func _ready() -> void:
	hp = 10
<<<<<<< Updated upstream
	player = get_tree().get_first_node_in_group("player")
	animator.play("idle")
=======
	super()
>>>>>>> Stashed changes


func _physics_process(delta: float) -> void:
	target = get_target()
	if current_state == State.MOVE and grounded:
		if hp <= 5: # Second phase
			jump()

		if %RayCast2D.get_collider() is Player and player.hp > 0 and hp > 5: # Attack
			current_state = State.ATTACK

		direction = sign(target.x)
		if player.current_state != State.CUTSCENE:
			velocity.x = direction * MOVE_SPEED

<<<<<<< Updated upstream
	if hp == 0:
		Manager.change_music("victory")
		$"../Door".enterable = true

	if not grounded and hp > 0: # Move to target if jumping
=======
	if not is_on_floor() and hp > 0: # Move to target if jumping
>>>>>>> Stashed changes
		velocity.x = jumping_destination * 2.5
	
	if is_on_floor() and not grounded:
		Manager.shake_strength = 30

	super(delta)


func jump(destination : Vector2 = target) -> void:
	jumping_destination = destination.x
	velocity.y = JUMP_VELOCITY
	%JumpCooldown.start()

func _on_jumping_hit_box_body_entered(body: Player) -> void:
	body.take_damage(1, global_position)

func _on_hit_box_body_entered(body: Player) -> void:
<<<<<<< Updated upstream
	body.take_damage(1)

func _on_jump_cooldown_timeout() -> void:
	queued_jump = true
=======
	body.take_damage(1, global_position)

func _on_landed() -> void:
	Manager.shake_strength = 30
	player.set_collision_mask_value(4, false)
>>>>>>> Stashed changes
