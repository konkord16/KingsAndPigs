extends CharacterBody2D

const GRAVITY = 0.1
var force

func _ready():
	velocity.x = clamp(force, -10 , 10)
	

func _physics_process(delta):
	velocity.y += GRAVITY
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider() 
		if collider.is_in_group("player"):
			collider.take_damage()
		await despawn()
		

func take_damage():
	velocity = velocity.rotated(PI)
	

func despawn():
	set_physics_process(false)	
	set_collision_layer_value(3, false)
	$Sprite2D.visible = false
	$GPUParticles2D.emitting = true
	await $GPUParticles2D.finished		
	queue_free()
