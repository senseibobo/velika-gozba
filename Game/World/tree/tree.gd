extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var mat = $object/canopy.get_material().duplicate()
	$object/canopy.set_material(mat)
	mat.set_shader_param("nestotamo",global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
