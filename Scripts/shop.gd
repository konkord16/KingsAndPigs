extends Area2D

var open := true
var has_bomb := true
var shopping_player : Player = null
@onready var shopkeeper: BaseEntity = %Shopkeeper

func _physics_process(delta: float) -> void:
	if shopkeeper.hp != 3 and open:
		open = false
		set_deferred("monitoring", false)
		$BombDisplay.monitoring = true

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
	if event.is_action_pressed("up") and shopping_player and open:
		if Player.diamonds >= 10:
			Player.diamonds -= 10
			Player.bombs += 1
			shopping_player.ui.update()
			%Shopkeeper/AudioPlayer.stream = load("res://Sounds/pickup.mp3")
			%Shopkeeper/AudioPlayer._play()
			%BombDisplay.on_body_entered(shopping_player)
			has_bomb = false
