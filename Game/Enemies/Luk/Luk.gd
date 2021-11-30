extends Enemy

var damage : float = 70

var exploded : bool = false

func _physics_process(delta):
	_handle_movement(delta)

func _handle_movement(delta):
	if spotted_player:
		var vec = Global.player.global_position - global_position
		var dir = vec.normalized()
		var dist = vec.length()
		move_and_slide(dir*movement_speed)
		if dist < 200:
			movement_speed = 300
			if dist < 120 and not exploded:
				explode()

func explode():
	exploded = true
	yield(get_tree().create_timer(0.2,false),"timeout")
	if Global.player.global_position.distance_to(global_position) < 70:
		Global.player.hit(damage,self)
		var particles = preload("res://Particles/LukEksplozijaParticles.tscn").instance()
		particles.global_position = global_position
		get_parent().add_child(particles)
		yield(get_tree(),"idle_frame")
		death(self)
