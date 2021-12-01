extends BulletGenerator

export var width : float = 1500
export var inner_width : float = 750
export var wave_frequency : float = 3
export var density : float = 30
export var spacing : float = 50
export var rand : Vector2
export var rand_angle : float = 0.0
export var offset : Vector2
export(float,0,1) var rand_speed = 0
var t : float = 0.0


func _process(delta):
	t += delta

func shoot() -> void:
	emit_signal("shot")
	var count = density*width/100
	for i in range(count):
		var bullet = bullet_script.new()
		var ww = width/2
		var iw = inner_width/2
		var pos : Vector2 = global_position
		var p = i/count * width - ww
		var q = sin(t) * iw
		if abs(p-q) < spacing: continue
		pos.x += p
		pos += offset
		pos += Vector2(rand_range(-1,1),rand_range(-1,1)) * rand
		bullet.velocity = Vector2.DOWN.rotated(rand_range(-rand_angle,rand_angle))*(speed*(1-rand_range(0,rand_speed)))
		bullet.position = pos
		add_bullet(bullet)
	
	
