extends BaseEntity

const JUMP_VELOCITY = -500.0
const MOVE_SPEED = 50.0

var player : Player
var direction : int
var jumping_destination : float
var queued_jump := false

func _ready() -> void:
	hp = 10
	player = get_tree().get_first_node_in_group("player")
	animator.play("idle")


func _physics_process(delta: float) -> void:
	if current_state == State.MOVE and grounded:
		if hp <= 5: # Second phase
			queued_jump = true

		if queued_jump:
			jump()

		if %RayCast2D.get_collider() is Player and player.hp > 0 and hp > 5: # Attack
			current_state = State.ATTACK

		direction = sign(to_local(player.global_position).x)
		if player.current_state != State.CUTSCENE:
			velocity.x = direction * MOVE_SPEED

	if hp == 0:
		Manager.change_music("victory")
		$"../Door".enterable = true

	if not grounded and hp > 0: # Move to target if jumping
		velocity.x = jumping_destination * 2.5
	
	if is_on_floor() and not grounded:
		Manager.shake_strength = 30

	super(delta)


func jump(target : Vector2 = player.global_position) -> void:
	jumping_destination = to_local(target).x
	velocity.y = JUMP_VELOCITY
	%JumpCooldown.start()
	queued_jump = false


func _on_jumping_hit_box_body_entered(body: Player) -> void:
	body.take_damage(1)

func _on_hit_box_body_entered(body: Player) -> void:
	body.take_damage(1)

func _on_jump_cooldown_timeout() -> void:
	queued_jump = true
