extends CharacterBody2D

var force

func _ready():
	velocity.x = force

func _physics_process(delta):
	velocity.y += .1
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider() 
		if collider.is_in_group("player"):
			collider.take_damage()
			queue_free()
		else:
			queue_free()

func take_damage():
	velocity = velocity.rotated(PI)
