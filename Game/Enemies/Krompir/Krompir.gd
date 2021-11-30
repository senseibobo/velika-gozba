extends Enemy

export var damage = 30
export var deceleration : float = 500.0
export var dash_interval : float = 2.0
var dash_timer : float = 0.0
var velocity : Vector2
var hit_timer : float = 0.0


func _physics_process(delta):
	if stagger_timer > 0: return
	if spotted_player:
		_handle_movement(delta)
	else:
		var vec = start_pos-global_position
		var dist = vec.length()
		if dist < 20:
			var dir = vec.normalized()
			move_and_slide(dir*movement_speed)
			if dir.x != 0:
				sprite.scale.x = -abs(sprite.scale.x)*sign(dir.x)

func _handle_movement(delta):
	dash_timer -= delta
	hit_timer -= delta
	if dash_timer <= 0 and is_instance_valid(Global.player):
		dash_timer = dash_interval
		velocity = global_position.direction_to(Global.player.global_position) * movement_speed
	move_and_slide(velocity)
	velocity = velocity.move_toward(Vector2(),deceleration*delta)
	if sign(velocity.x) != 0:
		sprite.scale.x = -abs(sprite.scale.x)*sign(velocity.x)
	if velocity.length() > 10 and hit_timer <= 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider == Global.player:
				Global.player.hit(damage,self)
				velocity = Vector2()
				hit_timer = dash_interval/2.0
				break
