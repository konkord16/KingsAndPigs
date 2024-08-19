extends Control

signal started

func _on_play_pressed() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate",Color(1,1,1,0), 0.25)
	%Exit.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Play.mouse_filter = Control.MOUSE_FILTER_IGNORE
	emit_signal("started")
	Manager.time = 0
	Manager.set_process(true)

func _on_exit_pressed() -> void:
	var tween : Tween = create_tween()
	tween.tween_property($FadeBlack, "modulate",Color(1,1,1,1), 0.5)
	%Exit.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Play.mouse_filter = Control.MOUSE_FILTER_IGNORE
	await tween.finished
	get_tree().quit()
