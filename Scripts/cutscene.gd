extends AnimationPlayer

@export var pigs_leaving := false

func _physics_process(delta: float) -> void:
	if pigs_leaving:		
		for pig in %MarchinPigs.get_children():
			pig.velocity.x = 50
			if pig.global_position.x >= 790:
				pig.queue_free()

func _on_boss_trigger_body_entered(body: Node2D) -> void:
	get_tree().call_group("enemy", "say", "surprise")
	play("start_boss")
