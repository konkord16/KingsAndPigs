extends Area2D

var has_bomb := true
var shopping_player : Player = null
@onready var shopkeeper: BaseEntity = %Shopkeeper

func _physics_process(delta: float) -> void:
	if shopkeeper.hp != 3: 
		set_physics_process(false)
		set_process_input(false)
		set_deferred("monitoring", false)
		if %BombDisplay:
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
	if event.is_action_pressed("up") and shopping_player:
		if Player.diamonds >= 10:
			Player.diamonds -= 10
			shopping_player.ui.update()
			%Shopkeeper/AudioPlayer.stream = load("res://Sounds/pickup.mp3")
			%Shopkeeper/AudioPlayer._play()
			%BombDisplay._on_body_entered(shopping_player)
			has_bomb = false
