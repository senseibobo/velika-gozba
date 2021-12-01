extends Enemy


enum STATES {
	WALKING,
	SHOOTING
}

var approach_range : float = 500

onready var generator = $KrastavacGenerator

var old_spotted = false

func _physics_process(delta):
	if stagger_timer > 0: return
	if not old_spotted and spotted_player: 
		generator.shooting = true
	elif old_spotted and not spotted_player:
		generator.shooting = false
	old_spotted = spotted_player
	if is_instance_valid(Global.player) and spotted_player:
		_handle_movement()
	else:
		if not spotted_player:
			var vec = start_pos-global_position
			var dist = vec.length()
			if dist < 20:
				var dir = vec.normalized()
				move_and_slide(dir*movement_speed)
				if dir.x != 0:
					sprite.scale.x = -abs(sprite.scale.x)*sign(dir.x)

func _handle_movement():
	var pp = Global.player.global_position
	var dest : Vector2
	var ppr = sign(global_position.x - pp.x)
	dest.x = pp.x + ppr*approach_range
	dest.y = pp.y
	var dir = global_position.direction_to(dest)
	dir.y *= 2.0
	if global_position.distance_to(dest) > 10:
		move_and_slide(dir.normalized()*movement_speed)
	if dir.x != 0:
		sprite.scale.x = ppr*abs(sprite.scale.x)
