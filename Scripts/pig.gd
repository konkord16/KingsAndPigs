extends BaseEntity

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _physics_process(_delta):
	#handle ai by changing velocity and state to attack
	
	super(_delta)
