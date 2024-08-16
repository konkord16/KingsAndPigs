extends Control

@onready var bar : TextureProgressBar= $Healthbar/TextureProgressBar
@onready var heart : AnimatedSprite2D = $Healthbar/Heart
@onready var player : BaseEntity = owner

func _ready() -> void:
	await owner.ready
	visible = true
	update(true)

func update(start := false) -> void:
	if bar.value > player.hp and not start:
		heartbreak()
	bar.value = player.hp
	%DiamondAmount.text = str(player.diamonds)
	%BombAmount.text = str(player.bombs)
	
func heartbreak() -> void:
	heart.position.x = (66 + bar.value * 33) / 4
	heart.visible = true
	heart.play("break")
	await heart.animation_finished
	heart.visible = false
