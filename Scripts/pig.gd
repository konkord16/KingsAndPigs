extends BaseEntity

@export var aggressive := true # Whether the pig tries to attack the player or not
var speed := 50.0
const JUMP_VELOCITY = -280.0
const SEARCH_RANGE = Vector2(50, 50)
var direction := 1
var player : Player

func _ready() -> void:
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")	
	animator.play("idle")
	

func _process(_delta : float) -> void:
	if current_state == State.MOVE and aggressive:
		if %WallRay.is_colliding() and not %WallRay.get_collider() is BaseEntity : # Turn around if sees wall
			direction *= -1
		elif %WallRay.get_collider() == player and player.hp > 0: # Attack if sees player
			current_state = State.ATTACK

		if to_local(player.global_position).length() < SEARCH_RANGE.length(): 
			direction = sign(to_local(player.global_position).x) # Turn toward player if he's close
			if abs(to_local(player.global_position).y) > 23 and is_on_floor(): # Go up or down a layer
				if to_local(player.global_position).y > 0:
					if %FloorRay.get_collider():
						global_position.y += 1

				else:
					velocity.y = JUMP_VELOCITY
			else:
				direction = sign(to_local(player.global_position).x + player.sprite.scale.x * 15) # Turn toward player if he's close but avoid getting stuck on each other

		if player.current_state != State.CUTSCENE:
			velocity.x = direction * speed


func _on_attack_range_body_entered(body : Node2D) -> void:
		body.take_damage(1)
