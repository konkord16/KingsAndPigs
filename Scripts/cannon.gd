extends Node2D

@onready var animator = $AnimationPlayer
@onready var cannon_ball : PackedScene = preload("res://Scenes/cannon_ball.tscn")
@onready var ray_cast : RayCast2D = $RayCast
enum {
	IDLE,
	SHOOT,
	TURN,
}
var current_state = IDLE
var player : BaseEntity
var target : Vector2
var force : float

func _ready():
	await get_tree().physics_frame
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")	

func _physics_process(delta):
	if player:				
		target = to_local(player.global_position)
		ray_cast.target_position = target
	match current_state:
		IDLE:
			animator.play("idle")
			if ray_cast.is_colliding() and ray_cast.target_position.length() < 200 and player.current_state != 2 and target.y >= 0 :
				current_state = SHOOT				
				force = target.x / target.y * 1.5
		SHOOT:			
			animator.play("shoot")			
			await animator.animation_finished
			current_state = IDLE

func shoot():	 
	var ball_inst = cannon_ball.instantiate()
	ball_inst.force = force
	add_child(ball_inst)

