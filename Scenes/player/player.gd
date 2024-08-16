class_name Player
extends BaseEntity

@export var taking_input := true
@export var BOMB : PackedScene
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
static var diamonds := 0:
	set(value):
		if value > diamonds:
			overall_diamonds += value - diamonds
		diamonds = value
static var overall_diamonds := 0
static var bombs := 0
var enterable_door : Area2D = null
var move_dir : float 
@onready var ui: Control = $Camera2D/CanvasLayer/UI

func _ready() -> void:
	hp = Manager.hp
	current_state = State.CUTSCENE
	if get_tree().current_scene.scene_file_path == "res://Levels/level0.tscn":
		animator.play("wake_up")
	else:
		animator.play("door_out")
	await animator.animation_finished
	current_state = State.MOVE


func _process(delta: float) -> void:
	# Taking input
	direction = %Sprite2D.scale.x
	if current_state == State.MOVE and taking_input == true:
		if is_on_floor():
			if Input.is_action_pressed("jump"):
				velocity.y = JUMP_VELOCITY
			elif Input.is_action_pressed("down"):
				global_position.y += 1

		move_dir = Input.get_axis("left", "right")
		if move_dir:
			velocity.x = move_dir * SPEED
		else:
			velocity.x = 0
		
		if Input.is_action_just_pressed("attack") and is_on_floor():
			current_state = State.ATTACK
			
		if Input.is_action_just_pressed("up") and enterable_door and enterable_door.destination and enterable_door.enterable:
			enterable_door.enter()
			current_state = State.CUTSCENE
			invincible = true
			velocity = Vector2.ZERO
			global_position = enterable_door.global_position
			animator.play("door_in")
			Manager.hp = hp
			Manager.bombs = bombs
			Manager.current_diamonds = diamonds
			Manager.overall_diamonds = overall_diamonds

		if Input.is_action_just_pressed("bomb"):
			if bombs > 0:
				bombs -= 1
				ui.update()
				var inst_bomb : CharacterBody2D = BOMB.instantiate()
				inst_bomb.global_position = global_position
				call_deferred("add_sibling", inst_bomb)
		
		if Input.is_action_just_pressed("test"):
			get_tree().call_group("enemy", "say", "swear")


func _on_hitbox_body_entered(body : Node2D) -> void:
		if body.has_method("take_damage"):
			body.take_damage(1, direction)

func _on_hitbox_area_entered(area: Area2D) -> void:
		if area.has_method("take_damage"):
			area.take_damage(1, direction)

func trashtalk() -> void:
	get_tree().call_group("enemy","say","trashtalk")
