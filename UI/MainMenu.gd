extends Control


export var center_contained_path : NodePath
export var menu_offset : Vector2 = Vector2(0,80)
onready var cc : CenterContainer = get_node(center_contained_path)

func _process(delta):
	var screen_size = get_viewport_rect().size
	var mpos = get_viewport().get_mouse_position()
	cc.rect_position = screen_size/2 - (screen_size/2-mpos)/16.0 + menu_offset
