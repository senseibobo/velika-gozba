extends Enemy


export var attack_range : float = 78
export var damage : float = 25
export var attack_interval : float = 2.0
var attack_timer : float = 0.0
var velocity : Vector2 = Vector2()

func _process(delta):
	if is_instance_valid(Global.player): 
		_handle_movement(delta)
		_check_collision(delta)

func _check_collision(delta):
	attack_timer -= delta
	if attack_timer <= 0 and global_position.distance_to(Global.player.global_position) < attack_range:
		Global.player.hit(damage,self)
		attack_timer = attack_interval
		print("Hit")

func _handle_movement(delta):
	var dir : Vector2
	dir = global_position.direction_to(Global.player.global_position)
	if dir.x != 0:
		sprite.scale.x = -abs(sprite.scale.x)*sign(dir.x)
	move_and_slide(dir*movement_speed)
