extends AnimationPlayer

var shopping_player : Player = null

func _on_shop_area_body_entered(body: Node2D) -> void:
	if body is Player:
		play("enter_shop")
		shopping_player = body

func _on_shop_area_body_exited(body: Node2D) -> void:
	if body is Player:	
		shopping_player = null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up") and shopping_player:
		if Player.diamonds >= 10:
			Player.diamonds -= 10
			Player.bombs += 1
			shopping_player.ui.update()
			$"../BombDisplay".visible = false
