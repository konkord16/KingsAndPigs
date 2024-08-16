extends AnimationPlayer

@export var pigs_leaving := false
var pigs_on_scene := 5
var pigs_on_standby := 0

func _physics_process(delta: float) -> void:
	if pigs_leaving and pigs_on_scene:
		for pig in %MarchinPigs.get_children():
			if not pig.hp <= 0:
				pig.velocity.x = 50
			if pig.global_position.x >= 740:					
				var tween : Tween = pig.create_tween()
				tween.tween_property(pig, "modulate",Color(1,1,1,0), 0.25)
				await tween.finished
				pigs_on_scene -= 1
				pigs_on_standby += 1
				pig.queue_free()


func _on_boss_trigger_body_entered(body: Node2D) -> void:
	get_tree().call_group("enemy", "say", "surprise", true)
	play("start_boss")
	Manager.change_music("boss_music")
	$"../BossTrigger".set_deferred("monitoring", false)

