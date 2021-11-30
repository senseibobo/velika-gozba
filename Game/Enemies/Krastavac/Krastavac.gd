extends Enemy


enum STATES {
	WALKING,
	SHOOTING
}

var state : int = STATES.WALKING 
var approach_range : float = 500

onready var generator = $KrastavacGenerator

func _physics_process(delta):
	if stagger_timer > 0: return
	if is_instance_valid(Global.player) and state == STATES.WALKING and spotted_player:
		generator.shooting = true
		_handle_movement()
	else:
		generator.shooting = false
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
