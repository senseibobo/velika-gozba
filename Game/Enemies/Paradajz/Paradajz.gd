extends Enemy


var velocity : Vector2 = Vector2()

func _process(delta):
	_handle_movement(delta)

func _handle_movement(delta):
	var dir : Vector2
	if is_instance_valid(Global.player): 
		dir = global_position.direction_to(Global.player.global_position)
		if dir.x != 0:
			sprite.scale.x = -abs(sprite.scale.x)*sign(dir.x)
	move_and_slide(dir*movement_speed)

