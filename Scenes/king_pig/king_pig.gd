extends BaseEntity

signal phase_change
@export var attacking := true
const JUMP_VELOCITY = -500.0
const MOVE_SPEED = 50.0
var jumping_destination : float
var prev_hp := 15

func _ready() -> void:
	hp = 15
	super()


func _physics_process(delta: float) -> void:
	target = get_target()
	%JumpCooldown.paused = not attacking
	if prev_hp != hp:
		if hp == 10 or hp == 5:
			emit_signal("phase_change")
	prev_hp = hp
	if current_state == State.MOVE and grounded and attacking:
		if hp <= 5: # Second phase
			jump()

		if %RayCast2D.get_collider() is Player and player.hp > 0 and hp > 5: # Attack
			current_state = State.ATTACK

		direction = sign(target.x)
		
		if player.current_state != State.CUTSCENE:
			velocity.x = direction * MOVE_SPEED

	if not is_on_floor() and hp > 0: # Move to target if jumping
		velocity.x = jumping_destination * 2.5
	super(delta)


func jump(destination : Vector2 = target, global := false) -> void:
	if hp <= 0 or player.hp <= 0:
		return
	if global:
		destination = to_local(destination)
	jumping_destination = destination.x
	velocity.y = JUMP_VELOCITY + 2 * to_local(destination).y
	%JumpCooldown.start()

func victory() -> void:
	Manager.change_music("victory")
	$"../Door".enterable = true

func _on_jumping_hit_box_body_entered(body: Node2D) -> void:
	body.take_damage(1, direction)

func _on_hit_box_body_entered(body: Node2D) -> void:
	body.take_damage(1, direction)

func _on_landed() -> void:
	if player.global_position.y < -75:
		attacking = true
	if player.global_position.x > 200:
		Manager.shake(30)
		player.set_collision_mask_value(4, false)
		get_tree().call_group("crate", "take_damage", 1, 1)
