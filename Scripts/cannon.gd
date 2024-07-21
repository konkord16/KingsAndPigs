extends Node2D

@onready var animator = $AnimationPlayer
@onready var cannon_ball : PackedScene = preload("res://Scenes/cannon_ball.tscn")
var player : CharacterBody2D

func _ready():
	await get_tree().physics_frame
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("player")	

func _physics_process(delta):
	if Input.is_action_just_pressed("test"):
		animator.play("shoot")
		

func shoot():
	var target = to_local(player.global_position)	
	if target.y >= 0:# for the duration of debugging
		animator.play("shoot")				
		var force = target.x / target.y * 1.5
		var ball_inst = cannon_ball.instantiate()
		ball_inst.force = force
		add_child(ball_inst)
		await animator.animation_finished
		animator.play("idle")

