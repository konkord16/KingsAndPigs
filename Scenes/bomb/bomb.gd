extends CharacterBody2D

@export var destination := 0.0
const GRAVITY = 20
var hp := 3

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY
	if destination and not is_on_floor():
			velocity.x = destination / 0.5
	else:
		velocity.x = 0
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(3, sign(to_local(body.global_position).x))

func take_damage(amount : int, dir : int ) -> void:
	hp -= amount
	if hp <= 0 and %AnimationPlayer.current_animation_position < 1:
		%AnimationPlayer.seek(1)
	velocity.y = -250
	destination = dir * 150
