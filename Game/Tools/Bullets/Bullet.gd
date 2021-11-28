class_name Bullet

var position : Vector2
var velocity : Vector2
var rotation : float
var life_time : float = 2.0
var current_time : float = 0.0

func _process(delta) -> void:
	current_time += delta
	position += velocity*delta
	
func check_collision(radius) -> bool:
	if is_instance_valid(Global.player):
		var dist_to_player : float = position.distance_to(Global.player.global_position)
		if dist_to_player < radius:
			Global.player.hit()
			return true
	return false 
