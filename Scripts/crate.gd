extends RigidBody2D

var rng := RandomNumberGenerator.new()
const collectible := preload("res://Scenes/collectible.tscn")

func take_damage(amount : int) -> void:
	$Sprite2D.visible = false
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, false)
	$GPUParticles2D.emitting = true
	drop_item()
	await $GPUParticles2D.finished
	queue_free()
	

func drop_item() -> void:
	rng.randomize()
	if rng.randf() > 0.5:
		var inst_collectible := collectible.instantiate()
		inst_collectible.global_position = global_position + Vector2(0, -9)
		call_deferred("add_sibling", inst_collectible)
