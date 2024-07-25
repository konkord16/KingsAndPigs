extends RigidBody2D

func take_damage():
	$Sprite2D.visible = false
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, false)
	$GPUParticles2D.emitting = true
	await $GPUParticles2D.finished
	queue_free()
