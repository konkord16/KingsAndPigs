class_name BaseEntity
extends CharacterBody2D

signal landed
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
var player : Player
var rng := RandomNumberGenerator.new()
var direction := 1
var target : Vector2
var grounded := true
var invincible := false
var hp := 3
@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var particles : GPUParticles2D = $GPUParticles2D
@onready var speech: AnimatedSprite2D = $Speech


func _ready() -> void:
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")


func _physics_process(_delta : float) -> void:	
	if not is_on_floor():
		velocity.y += GRAVITY
	elif not grounded:
		emit_signal("landed")
	grounded = is_on_floor()
	
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


func take_damage(amount : int, dir : int ) -> void:
	if invincible:
		return
	if self is Player:
		Manager.shake_strength += 10
	invincible = true
	current_state = State.HURT
	hp -= amount
	animator.play("hit")
	await animator.animation_finished
	if hp <= 0:
		animator.play("dead")
		current_state = State.CUTSCENE
		emit_signal("died")
	else:
		invincible = false
		current_state = State.MOVE


func say(phrase : String, global := false) -> void:
	if (global_position.distance_to(player.global_position) > 170 or hp <= 0) and not global:
		return
	if phrase == "trashtalk":
		var chance := rng.randf()
		if chance <= 0.25:
			phrase = "dead"
		elif chance <= 0.5:
			phrase = "loser"
		else:
			return
	speech.visible = true
	speech.play(phrase)
	$Speaking._play()
	await speech.animation_finished
	speech.visible = false

func get_target() -> Vector2:
	return to_local(player.global_position)
