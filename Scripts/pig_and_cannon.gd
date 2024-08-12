extends StaticBody2D

enum State {
	IDLE,
	SHOOT,
	TURN,
	DEAD,
	HIT,
}
var current_state : State = State.IDLE
var player : BaseEntity
var target : Vector2
var hp : int = 1
@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var cannon_ball : PackedScene = preload("res://Scenes/cannon_ball.tscn")
@onready var direction : int

func _ready() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")	
	

func _physics_process(delta : float) -> void:
	direction = -$Cannon/CannonSprite.scale.x
	if player:
		target = $Cannon.to_local(player.global_position) - %RayCast.position
		%RayCast.target_position = target.normalized() * 200
		
	match current_state:
		State.IDLE:
			animator.play("idle")			
			if %RayCast.is_colliding() and %RayCast.get_collider().is_in_group("player"):
				if player.hp > 0 and target.y >= -10:
					current_state =  State.SHOOT
			if sign(target.x) != direction:
				current_state =  State.TURN

		State.SHOOT:
			animator.play("shoot")			
			await animator.animation_finished
			current_state =  State.IDLE
			
		State.TURN:
			if animator.current_animation == "idle":
				animator.play("turn_right")	if direction == -1  else animator.play("turn_left")				
			await animator.animation_finished
			current_state = State.IDLE
			

func shoot() -> void:
	var force : float = target.x / sqrt(2 * abs(target.y) / 0.1)
	if target.y < -5 or sign(target.x) != direction:
		force = 10 * direction
	var ball_inst := cannon_ball.instantiate()
	ball_inst.force = force
	add_child(ball_inst)
	

func take_damage(amount : int) -> void:
	if current_state != State.DEAD:
		current_state = State.HIT
		hp -= 1
		animator.play("hit")
		await animator.animation_finished	
		if hp <= 0:
			current_state = State.DEAD
			animator.play("dead")
		else:
			current_state = State.IDLE
