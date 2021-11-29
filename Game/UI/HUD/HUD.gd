extends CanvasLayer

var max_health : float
var health : float

export var healthbar_path : NodePath

onready var healthbar = get_node(healthbar_path)

func _process(delta):
	if is_instance_valid(Global.player):
		healthbar.get_material().set_shader_param("health_percentage",Global.player.health/Global.player.max_health)
