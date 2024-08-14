extends BaseEntity

const SPEED := 150.0
const UP_VEL := -300.0 
@onready var bomb := preload("res://Scenes/bomb.tscn")


func _physics_process(delta: float) -> void:
	if current_state != State.MOVE:
		return
	target = get_target()
	if target.length() <= 50:
		velocity.x = SPEED * -sign(target.x)
	elif target.length() <= 150:
		current_state = State.ATTACK
		%Sprite2D.scale.x = -sign(target.x)

	super(delta)

func _throw_bomb() -> void:
	var bomb_inst := bomb.instantiate()
	bomb_inst.velocity.y = UP_VEL
	bomb_inst.destination = target.x
	bomb_inst.global_position = global_position
	call_deferred("add_sibling", bomb_inst)
