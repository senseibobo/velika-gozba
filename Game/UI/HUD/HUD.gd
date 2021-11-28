extends Control

var max_health : float
var health : float


func set_health(new_health):
	health = new_health
	update_healthbar()

func set_max_health(new_max_health):
	max_health = new_max_health
	update_healthbar()

func update_healthbar():
	pass
