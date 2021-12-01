extends CanvasLayer

var max_health : float
var health : float

export var healthbar_path : NodePath

onready var healthbar = get_node(healthbar_path)

func _process(delta):
	if is_instance_valid(Global.player):
		healthbar.get_material().set_shader_param("health_percentage",Global.player.health/Global.player.max_health)
	$sc/hb/amount.text = str(LevelManager.score)
	$sc/mutliplier.text = "x%.2f" % LevelManager.score_multiplier
	$sc.modulate = Color.from_hsv(1.0,(LevelManager.score_multiplier-1)/3.0*(LevelManager.score_timer/LevelManager.score_drop_time),1.0,1.0)
