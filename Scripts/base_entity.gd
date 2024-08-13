class_name BaseEntity
extends CharacterBody2D

signal died
@export var flipped : bool # For if the asset is drawn the wrong way
@export var current_state : = State.MOVE
enum State{
	MOVE,
	ATTACK,
	CUTSCENE,
	HURT,
}
const GRAVITY = 20
var rng := RandomNumberGenerator.new()
var grounded := true
var hp := 3
var invincible := false
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
			if hp <= 0:
				animator.play("dead")
			else:
				current_state = State.MOVE

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
	if not invincible:
		if self is Player:
			Manager.shake_strength = 10
		invincible = true
		current_state = State.HURT
		hp -= amount
		animator.play("hit")
		await animator.animation_finished
		if hp <= 0:
			animator.play("dead")
			current_state = State.CUTSCENE
		else:
			invincible = false
			current_state = State.MOVE

func say(phrase : String) -> void:
	if phrase == "trashtalk":
		var chance := rng.randf()
		if chance > 0.5:
			phrase = "dead"
		elif chance > 0.75:
			phrase = "loser"
		else:
			return
	speech.visible = true
	speech.play(phrase)
	$Speaking._play()
	await speech.animation_finished
	speech.visible = false
