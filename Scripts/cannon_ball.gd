extends Area2D

const GRAVITY = 0.1
var force : float
var velocity := Vector2.ZERO

func _ready() -> void:
	var direction : int = sign(force)
	velocity.x = clamp(abs(force), 1 , 8) * direction


func _physics_process(delta : float) -> void:
	velocity.y += GRAVITY
	global_position += velocity
	

func take_damage(amount : int) -> void:
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
			body.take_damage(1)
	despawn()
	
