extends Enemy


enum STATES {
	WALKING,
	SHOOTING
}

var state : int = STATES.WALKING 
var approach_range : float = 500

func _process(delta):
	if state == STATES.WALKING:
		_handle_movement()

func _handle_movement():
	if is_instance_valid(Global.player):
		var pp = Global.player.global_position
		var dest : Vector2
		var ppr = sign(global_position.x - pp.x)
		dest.x = pp.x + ppr*approach_range
		dest.y = pp.y + 20
		var dir = global_position.direction_to(dest)
		dir.y *= 2.0
		if global_position.distance_to(dest) > 10:
			move_and_slide(dir.normalized()*movement_speed)
		if dir.x != 0:
			sprite.scale.x = ppr*abs(sprite.scale.x)
