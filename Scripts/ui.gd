extends Control

@onready var bar = $Healthbar/TextureProgressBar
@onready var heart = $Healthbar/Heart
@onready var player : BaseEntity = owner
@onready var label = $Diamonds/Amount

func _ready():
	bar.value = player.hp

func update():
	if bar.value > player.hp:
		heartbreak()
	bar.value = player.hp
	label.text = str(Score.diamonds)
	
func heartbreak():
	heart.position.x = (66 + bar.value * 33) / 4
	heart.visible = true
	heart.play("break")
	await heart.animation_finished
	heart.visible = false
