extends Particles2D


var time : float = 0.0
const life_time : float = 2.0

func _process(delta):
	time += delta
	if time > life_time:
		queue_free()
