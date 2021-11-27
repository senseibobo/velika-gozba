class_name Bullet

var position : Vector2
var velocity : Vector2
var rotation : float
var life_time : float = 2.0
var current_time : float = 0.0

func _process(delta):
	current_time += delta
	position += velocity*delta
