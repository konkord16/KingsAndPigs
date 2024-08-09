extends BaseEntity

const JUMP_VELOCITY = -500.0
var player : Player
var jumping_destination : float
@export var shake_strength := 0.0
var shake_fade := 0.3

func _ready() -> void:
	hp = 10
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("test"):
		jump()
	
	if shake_strength > 0: # Shaking the camera 
		print("shaking")
		shake_strength = lerpf(shake_strength, 0, shake_fade)
		if shake_strength < 0.1 and shake_strength < 0.1:
			shake_strength = 0
		var offset := Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
		player.global_position.y += shake_strength * 0.1
		%Camera2D.offset = offset

	if not grounded:
		velocity.x = jumping_destination * 1.8
		
	super(delta)
	
func jump(target : Vector2 = player.global_position) -> void:
	jumping_destination = to_local(target).x
	velocity.y = JUMP_VELOCITY
