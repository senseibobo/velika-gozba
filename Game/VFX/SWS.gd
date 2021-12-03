extends CanvasLayer

const shaders = [
	preload("res://VFX/Shaders/default.tres"),
	preload("res://VFX/Shaders/flipped.tres"),
	preload("res://VFX/Shaders/grayscale.tres"),
	preload("res://VFX/Shaders/rainbow.tres"),
	preload("res://VFX/Shaders/wavey.tres"),
	preload("res://VFX/Shaders/darkness.tres")
]

var current_shader : int = 0

func next_shader():
	current_shader = (current_shader+1)%shaders.size()
	$ColorRect.set_material(shaders[current_shader])
