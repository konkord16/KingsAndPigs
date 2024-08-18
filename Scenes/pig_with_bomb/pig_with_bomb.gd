extends BaseEntity

@export var bomb : PackedScene
const SPEED := 90.0
const UP_VEL := -300.0 
var wall_ray_hit : int
var cornered := false


func _physics_process(delta: float) -> void:
	if current_state != State.MOVE:
		return
	target = get_target()	
	wall_ray_hit = 1 if %WallRayRight.is_colliding() else -1 if %WallRayLeft.is_colliding() else 0
	if target.length() <= 125:
		%RayCast2D.target_position = target
	if %RayCast2D.get_collider() is Player:
		if target.length() <= 75 and not wall_ray_hit:
			direction = -sign(target.x)
		else:
			current_state = State.ATTACK
			%Sprite2D.scale.x = -sign(target.x)
	elif wall_ray_hit == direction:
		direction *= -1

	velocity.x = SPEED * direction

	super(delta)


func throw_bomb() -> void:
	var bomb_inst := bomb.instantiate()
	bomb_inst.velocity.y = UP_VEL + 2 * target.y
	bomb_inst.destination = max(30, abs(target.x)) * -%Sprite2D.scale.x
	bomb_inst.global_position = global_position
	call_deferred("add_sibling", bomb_inst)


func drop_bomb() -> void:
	var bomb_drop := bomb.instantiate()
	bomb_drop.global_position = global_position + Vector2(0, -5)
	call_deferred("add_sibling", bomb_drop)
