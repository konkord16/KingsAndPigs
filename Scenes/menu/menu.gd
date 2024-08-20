extends Control

signal started

func _ready() -> void:
	while true:
		var tween : Tween = create_tween()
		tween.tween_property(%TextureRect, "position:y", 10, 1).as_relative().set_trans(Tween.TRANS_QUAD)
		tween.tween_property(%TextureRect, "position:y", -10, 1).as_relative().set_trans(Tween.TRANS_QUAD)
		await tween.finished

func _on_play_pressed() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate",Color(1, 1, 1, 0), 0.25)
	%Exit.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Play.mouse_filter = Control.MOUSE_FILTER_IGNORE
	emit_signal("started")
	Manager.time = 0
	Manager.set_process(true)
	await tween.finished
	visible = false

func _on_exit_pressed() -> void:
	var tween : Tween = create_tween()	
	tween.tween_property($FadeBlack, "color", Color(0, 0, 0), 0.5)
	%Exit.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Play.mouse_filter = Control.MOUSE_FILTER_IGNORE
	await tween.finished
	get_tree().quit()
