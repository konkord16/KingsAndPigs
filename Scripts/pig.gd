extends BaseEntity

var speed := 50.0
const JUMP_VELOCITY = -280.0
const SEARCH_RANGE = Vector2(50, 50)
var direction := 1
var player : CharacterBody2D

func _ready() -> void:	
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")


func _process(_delta : float) -> void:
	if current_state == State.MOVE:
		if %WallRay.is_colliding() and not %WallRay.get_collider() is BaseEntity : # Turn around if sees wall
			direction *= -1	
		elif %WallRay.get_collider() == player and player.hp > 0: # Attack if sees player
			current_state = State.ATTACK			

		if to_local(player.global_position).length() < SEARCH_RANGE.length(): # Turn toward player if he's close
			direction = sign(to_local(player.global_position).x + player.sprite.scale.x * 15)			
			if abs(to_local(player.global_position).y) > 23 and is_on_floor():
				if to_local(player.global_position).y > 0:
					global_position.y += 1
					
				else:
					velocity.y = JUMP_VELOCITY		
		
		velocity.x = direction * speed


func _on_attack_range_body_entered(body : Node2D) -> void:
		body.take_damage(1)
