extends Control

@onready var bar : TextureProgressBar= $Healthbar/TextureProgressBar
@onready var heart : AnimatedSprite2D = $Healthbar/Heart
@onready var player : BaseEntity = owner
@onready var label : Label = $Diamonds/Amount

func _ready() -> void:
	visible = true
	update()

func update() -> void:
	if bar.value > player.hp:
		heartbreak()
	bar.value = player.hp
	label.text = str(player.diamonds)
	if player.bombs:
		$Bomb.visible = true
	else:
		$Bomb.visible = false
	
func heartbreak() -> void:
	heart.position.x = (66 + bar.value * 33) / 4
	heart.visible = true
	heart.play("break")
	await heart.animation_finished
	heart.visible = false
