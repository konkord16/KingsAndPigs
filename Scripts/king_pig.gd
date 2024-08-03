extends BaseEntity

var direction := 1
var target := Vector2(600,0)

func _physics_process(delta: float) -> void:
	print(global_position.x - target.x)
	direction = sign(to_local(target).x)
	if -10 > (global_position.x - target.x) or (global_position.x - target.x) > 10:		
		velocity.x = 30 * direction
	
	
func _ready() -> void:
	animator.play("idle")
