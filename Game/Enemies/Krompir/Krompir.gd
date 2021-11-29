extends Enemy

export var damage = 30
export var deceleration : float = 500.0
export var dash_interval : float = 2.0
var dash_timer : float = 0.0
var velocity : Vector2


func _process(delta):
	_handle_movement(delta)

func _handle_movement(delta):
	dash_timer -= delta
	if dash_timer <= 0 and is_instance_valid(Global.player):
		dash_timer = dash_interval
		velocity = global_position.direction_to(Global.player.global_position) * movement_speed
	move_and_slide(velocity)
	velocity = velocity.move_toward(Vector2(),deceleration*delta)
	if sign(velocity.x) != 0:
		sprite.scale.x = -abs(sprite.scale.x)*sign(velocity.x)
	if velocity.length() > 10:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider == Global.player:
				Global.player.hit(damage,self)
				velocity = Vector2()
