extends TileMap



func _ready() -> void:
	var minutes := fmod(Manager.time, 3600) / 60
	var seconds := fmod(Manager.time, 60)
	var msec := fmod(Manager.time, 1) * 100
	$DiamondsCollected.text = ("You have collected\n" + str(Player.overall_diamonds) + "\n diamonds")
	$TimeTook.text = ("It took you " + "%02d:" % minutes + "%02d:" % seconds +  "%03d" % msec)
