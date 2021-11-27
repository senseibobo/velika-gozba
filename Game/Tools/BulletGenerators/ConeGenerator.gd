extends BulletGenerator



export var shot_count : int = 5
export var cone_angle : float = 45.0
export var rotation_speed : float = 0.0
export var current_rotation : float = 0.0

func shoot():
	for i in shot_count:
		var place = i - shot_count/2.0
		var rot = current_rotation + (place+0.5)*(deg2rad(cone_angle)/shot_count)
		var bullet : Bullet = bullet_script.new()
		bullet.rotation = rot
		bullet.position = global_position
		bullet.velocity = Vector2.RIGHT.rotated(rot)*speed
		add_bullet(bullet)
	current_rotation += rotation_speed
	
	
