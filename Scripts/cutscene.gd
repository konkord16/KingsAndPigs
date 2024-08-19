extends AnimationPlayer

@export var pig_scene : PackedScene
@export var pigs_leaving := false
var pigs_on_scene := 0
var pigs_on_standby := 0

func _physics_process(delta: float) -> void:
	if not pigs_leaving or %MarchingPigs.get_child_count() == 0:
		return
	for pig in %MarchingPigs.get_children():
		if not pig:
			return
		if pig.current_state == 0:
			pig.velocity.x = 50
		if pig.global_position.x >= 740:
			var tween : Tween = pig.create_tween()
			tween.tween_property(pig, "modulate",Color(1,1,1,0), 0.25)
			await tween.finished
			pigs_on_standby += 1
			pig.queue_free()


func reinforcement() -> void:
	if not pigs_on_standby:
		await get_tree().create_timer(1).timeout
		%KingPig.say("swear", true)
		play("jump_back")
		$"../Door/AnimatedSprite".play("closing")
		return
	for i in range(min(pigs_on_standby, 2)):
		var pig_inst := pig_scene.instantiate() 
		pig_inst.modulate = Color(1,1,1,0.25)
		pig_inst.global_position = Vector2(740, -40)
		pig_inst.direction = -1
		pig_inst.connect("died", _on_reinforcement_death)
		add_child(pig_inst)
		pigs_on_standby -= 1
		pigs_on_scene += 1
		var tween : Tween = pig_inst.create_tween()
		tween.tween_property(pig_inst, "modulate",Color(1,1,1,1), 0.2)
		await get_tree().create_timer(1.5).timeout


func _on_boss_trigger_body_entered(body: Node2D) -> void:
	get_tree().call_group("enemy", "say", "surprise", true)
	play("start_boss")
	Manager.change_music("boss_music")
	$"../BossTrigger".set_deferred("monitoring", false)


func _on_king_pig_phase_change() -> void:
	play("reinforcement")

func _on_reinforcement_death() -> void:
	pigs_on_scene -= 1
	if pigs_on_scene == 0 and not %KingPig.attacking:
		play("jump_back")
