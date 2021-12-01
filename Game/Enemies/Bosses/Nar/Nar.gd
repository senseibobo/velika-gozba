extends Boss


func _process(delta):
	$CanvasLayer/Healthbar.material.set_shader_param("health_percentage",health/max_health)
