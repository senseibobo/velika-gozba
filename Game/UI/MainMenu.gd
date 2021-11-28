extends Control


export var center_contained_path : NodePath
export var menu_offset : Vector2 = Vector2(0,120)
onready var cc : CenterContainer = get_node(center_contained_path)

func _process(delta) -> void:
	var screen_size : Vector2 = get_viewport_rect().size
	var mpos : Vector2 = get_viewport().get_mouse_position()
	cc.rect_position = screen_size/2 - (screen_size/2-mpos)/16.0 + menu_offset
	var c = cc.get_node("VBoxContainer").get_children()
	for button in c:
		var new_scale : float = 1.0 + int(button.get_global_rect().has_point(get_global_mouse_position()))*0.4
		button.rect_scale = lerp(button.rect_scale,Vector2(new_scale,new_scale),10*delta)
