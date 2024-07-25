extends Node

var hp := 3:
	set(value):
		hp = clamp(value, 0, 3)
		print(hp, "hp")
var diamonds := 0:
	set(value):
		diamonds = value
		print(diamonds, "diamonds")
