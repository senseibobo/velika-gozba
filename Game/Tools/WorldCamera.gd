extends Camera2D

class_name WorldCamera

enum {
	NODE,
	POSITION
}

var target_node : Node2D
var target_position : Vector2

var target_mode : int = NODE

export var follow_speed : float = 4.0

func _ready():
	zoom = Vector2(1.5,1.5)
	set_as_toplevel(true)
	current = true
	process_mode = Camera2D.CAMERA2D_PROCESS_PHYSICS

func _physics_process(delta):
	match target_mode:
		NODE:
			if is_instance_valid(target_node):
				global_position = lerp(global_position,target_node.global_position,follow_speed*delta)
		POSITION:
			global_position = lerp(global_position,target_position,follow_speed*delta)
