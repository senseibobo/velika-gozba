extends Node2D

var texture : Texture = preload("res://VFX/cursor.png")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	update()

func _draw():
	if not Global.in_game:
		draw_texture_rect(texture,Rect2(get_global_mouse_position(),Vector2(32,32)),false)
