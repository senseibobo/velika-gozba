extends KinematicBody2D

class_name Character

export var max_health : float
onready var health : float = max_health
export var movement_speed : float

func hit(damage,source):
	health = max(0,health-damage)
	if health <= 0:
		death(source)

func death(source):
	pass
