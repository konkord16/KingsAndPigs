extends BaseEntity

var speed = 50.0
const JUMP_VELOCITY = -300.0
const SEARCH_RANGE = Vector2(50, 50)
var direction = 1
var player

func _ready():
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")	

func _physics_process(_delta):
	if current_state == MOVE:				
		if $Sprite2D/WallRay.get_collider() is TileMap: # Turn around if sees wall
			direction *= -1	
		elif $Sprite2D/WallRay.get_collider() == player and player.hp > 0: # Attack if sees player
			current_state = ATTACK			
			
		if to_local(player.global_position).length() < SEARCH_RANGE.length(): # Turn toward player if he's close
			direction = sign(to_local(player.global_position).x + player.sprite.scale.x * 20)		
			
		if not $Sprite2D/FloorRay.is_colliding() and is_on_floor(): # Turn around if the platform ends
			direction *= -1	
			
		if current_state == MOVE: # Move if supposed to
			velocity.x = direction * speed
			
	super(_delta)

func _on_attack_range_body_entered(body):
		body.take_damage()
