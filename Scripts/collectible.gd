extends Area2D

var rng := RandomNumberGenerator.new()
enum types{
	heart,
	diamond,
}

var type : String

func _ready() -> void:
	rng.randomize()
	if rng.randf() >= 0.75:
		type = "heart"
	else:
		type = "diamond"
	$AnimatedSprite2D.play(str(type))	


func _on_body_entered(body : Node2D) -> void:
	if body.is_in_group("player"):
		if types[type] == types.heart:
			body.hp = clamp(body.hp + 1, 0, 3)
		elif types[type] == types.diamond:
			body.diamonds += 1
		body.ui.update()
		$AudioStreamPlayer2D._play()
		$AnimatedSprite2D.play(str(type) + "_hit")
		$CollisionShape2D.set_deferred("disabled", true)
		await $AnimatedSprite2D.animation_finished
		queue_free()
