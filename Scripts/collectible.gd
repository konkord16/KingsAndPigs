extends Area2D

enum types{
	heart,
	diamond
}
var type = types.keys().pick_random()

func _ready():
	$AnimatedSprite2D.play(str(type))	


func _on_body_entered(body):
	if body.is_in_group("player"):
		if types[type] == types.heart:
			Score.hp += 1
		elif types[type] == types.diamond:
			Score.diamonds += 1
		$AnimatedSprite2D.play(str(type) + "_hit")
		await $AnimatedSprite2D.animation_finished
		queue_free()
