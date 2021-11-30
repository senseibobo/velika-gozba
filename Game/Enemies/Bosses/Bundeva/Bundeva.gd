extends Boss


var velocity : Vector2 = Vector2(500,0)
export var steer_speed : float = 0.5

func _physics_process(delta):
	_handle_movement(delta)

func _handle_movement(delta):
	var dir_to_player = global_position.direction_to(Global.player.global_position)
	var angle_to_player = dir_to_player.angle()
	var s = sign(angle_to_angle(velocity.angle(),angle_to_player))
	velocity = velocity.rotated(s*steer_speed*delta)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		velocity = velocity.bounce(collision.normal)
	move_and_slide(velocity)

func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI
