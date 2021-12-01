extends StaticBody2D

func _ready():
	var mat = $object/canopy.get_material().duplicate()
	$object/canopy.set_material(mat)
	mat.set_shader_param("nestotamo",global_position)
