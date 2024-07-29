extends CharacterBody2D

const GRAVITY = 0.1
var force : float

func _ready() -> void:
	velocity.x = clamp(force, -10 , 10)
	

func _physics_process(delta : float) -> void:
	velocity.y += GRAVITY
	var collision := move_and_collide(velocity)
	if collision:
		var collider : Node2D = collision.get_collider() 
		if not collider is TileMap:
			collider.take_damage(1)
		await despawn()
		

func take_damage(amount : int) -> void:
	velocity = velocity.rotated(PI)
	

func despawn() -> void:
	set_physics_process(false)	
	set_collision_layer_value(3, false)
	$Sprite2D.visible = false
	$GPUParticles2D.emitting = true
	await $GPUParticles2D.finished		
	queue_free()
