extends Area2D

var has_bomb := true
var shopping_player : Player = null
@onready var shopkeeper: CharacterBody2D = %Shopkeeper



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if has_bomb:
			shopkeeper.say("price")
			shopping_player = body
		else:
			shopkeeper.say("hello")


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		shopping_player = null


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up") and shopping_player:
		if Player.diamonds >= 10:
			Player.diamonds -= 10
			Player.bombs += 1
			shopping_player.ui.update()
			%Shopkeeper/AudioPlayer.stream = load("res://Sounds/pickup.mp3")
			%Shopkeeper/AudioPlayer._play()
			%BombDisplay.visible = false
			has_bomb = false


func _on_shopkeeper_died() -> void:
	set_deferred("monitoring", false)
