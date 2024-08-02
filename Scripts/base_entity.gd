class_name BaseEntity
extends CharacterBody2D

@export var flipped : bool # For if the asset is drawn the wrong way
@export var current_state : = State.MOVE
enum State{
	MOVE,
	ATTACK,
	DEAD,
	CUTSCENE,
}
const GRAVITY = 20
var grounded := true
var hp := 3
@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var particles : GPUParticles2D = $GPUParticles2D
@onready var speech: AnimatedSprite2D = $Speech

func _physics_process(_delta : float) -> void:	
	if not is_on_floor():
		velocity.y += GRAVITY
	move_and_slide()
	match current_state:
		State.MOVE:
			animate()

		State.ATTACK:
			velocity.x = 0
			animator.play("attack")
			await animator.animation_finished
			current_state = State.MOVE

		State.DEAD:
			animator.play("dead")
			await animator.animation_finished
			if self is Player and is_inside_tree():
				get_tree().change_scene_to_file("res://Levels/death_menu.tscn")
	velocity.x = 0

func animate() -> void:
	if velocity.x > 0:
		sprite.scale.x = -1 if flipped else 1
	elif velocity.x < 0:                                                        
		sprite.scale.x = 1 if flipped else -1
		
	if not velocity:
		animator.play("idle")
	elif not velocity.y:
		animator.play("run")

	if not is_on_floor():
		if velocity.y < 0:
			animator.play("jump")
		elif velocity.y >= 0:
			animator.play("fall")

	if is_on_floor() and not grounded:
		animator.play("ground")	
	grounded = is_on_floor()	

	
func take_damage(amount : int) -> void:
	if not current_state in [State.DEAD, State.CUTSCENE]:			
		current_state = State.CUTSCENE
		hp -= amount
		animator.play("hit")
		await animator.animation_finished	
		if hp <= 0:
			current_state = State.DEAD
		else:
			current_state = State.MOVE

func say(phrase : String) -> void:	
	speech.visible = true
	speech.play(phrase)
	await speech.animation_finished
	speech.visible = false
