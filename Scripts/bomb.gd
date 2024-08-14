extends CharacterBody2D

@export var destination := 0.0
const GRAVITY = 20
var hp := 3

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY
	if destination and not is_on_floor():
			velocity.x = destination * 1.2
	else:
		velocity.x = 0
	move_and_slide()
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(3, global_position)

func take_damage(amount : int, origin : Vector2) -> void:
	hp -= amount
	if hp <= 0 and %AnimationPlayer.current_animation_position < 1:
		%AnimationPlayer.seek(1)
	velocity.y = -250
	destination = -sign(to_local(origin).x) * 150
	
