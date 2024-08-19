extends RigidBody2D

@export var collectible : PackedScene
var rng := RandomNumberGenerator.new()

func take_damage(amount : int, dir : int ) -> void:
	$AudioStreamPlayer2D._play()
	$Sprite2D.visible = false
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, false)
	$GPUParticles2D.emitting = true
	drop_item()
	await $GPUParticles2D.finished
	queue_free()


func drop_item() -> void:
	if rng.randf() <= 0.5:
		var inst_collectible := collectible.instantiate()
		inst_collectible.global_position = global_position + Vector2(0, -9)
		call_deferred("add_sibling", inst_collectible)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
