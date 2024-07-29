extends Area2D

enum types{
	heart,
	diamond
}
var type : String = types.keys().pick_random()

func _ready() -> void:
	$AnimatedSprite2D.play(str(type))	


func _on_body_entered(body : Node2D) -> void:
	if body.is_in_group("player"):
		if types[type] == types.heart:
			body.hp = clamp(body.hp + 1, 0, 3)
		elif types[type] == types.diamond:
			Score.diamonds += 1
		body.ui.update()
		$AnimatedSprite2D.play(str(type) + "_hit")
		$CollisionShape2D.set_deferred("disabled", true)
		await $AnimatedSprite2D.animation_finished
		queue_free()
