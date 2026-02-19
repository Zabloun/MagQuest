extends StaticBody2D
@export var total_health = 100

func hit(damage: int):
	total_health = total_health + damage
	print(total_health)
