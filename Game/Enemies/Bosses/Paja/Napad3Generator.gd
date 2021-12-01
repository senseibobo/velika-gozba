extends BulletGenerator

export var shot_count : int = 5
export var cone_angle : float = 45.0
export var rotation_speed : float = 0.0
export var current_rotation : float = 0.0
export var rand_offset : Vector2
export var rand_dir : float

func shoot() -> void:
	emit_signal("shot")
	for i in range(2):
		for j in shot_count:
			var hand = get_node("../Sprite/desni arm2/hand1") if i == 0 else get_node("../Sprite/desni arm3/hand2")
			var place : float = j - shot_count/2.0
			var rot : float = rand_range(-rand_dir,rand_dir)+current_rotation + (place+0.5)*(deg2rad(cone_angle)/shot_count)
			var bullet = bullet_script.new()
			bullet.rotation = rot
			bullet.position = hand.global_position + rand_offset*Vector2(rand_range(-1,1),rand_range(-1,1))
			bullet.velocity = Vector2.DOWN.rotated(rot)*speed
			add_bullet(bullet)
	current_rotation += rotation_speed
	
	
