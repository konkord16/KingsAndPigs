extends CharacterBody2D

const GRAVITY = 20

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(3)
