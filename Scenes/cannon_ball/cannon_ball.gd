extends Area2D

const GRAVITY = 0.1
var force : float
var velocity := Vector2.ZERO
var direction : int

func _ready() -> void:
	direction = sign(force)
	velocity.x = clamp(abs(force), 1 , 8) * direction


func _physics_process(delta : float) -> void:
	velocity.y += GRAVITY
	global_position += velocity
	

func take_damage(amount : int, dir : int ) -> void:
	if dir == direction:
		velocity = velocity.rotated(-PI/2 * dir)
	else:
		velocity = velocity.rotated(PI)


func despawn() -> void:
	set_physics_process(false)
	set_collision_mask(0)
	$Sprite2D.visible = false
	$GPUParticles2D.emitting = true
	await $GPUParticles2D.finished
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if not body is TileMap:
		body.take_damage(1, direction)
	despawn()
	
