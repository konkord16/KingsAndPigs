extends Area2D

@export var type : String
var rng := RandomNumberGenerator.new()
enum types{
	heart,
	diamond,
	bomb,
}

func _ready() -> void:
	if not type:
		if rng.randf() <= 0.20:
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
		elif types[type] == types.bomb:
			body.bombs += 1
		body.ui.update()
		$AudioStreamPlayer2D._play()
		$AnimatedSprite2D.play(str(type) + "_hit")
		$CollisionShape2D.set_deferred("disabled", true)
		await $AnimatedSprite2D.animation_finished
		queue_free()
