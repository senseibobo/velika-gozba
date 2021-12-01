extends CanvasLayer


export var cc_path : NodePath

onready var cc = get_node(cc_path)

var is_pausing : bool = false
var is_unpausing : bool = false

func _unhandled_key_input(event):
	if (Global.in_game or (not Global.in_menu and get_tree().paused)) and not Global.in_menu and event.scancode == 16777217 and not is_pausing and not is_unpausing:
		if not get_tree().paused:
			pause()
		else:
			unpause()


func pause():
	Global.in_game = false
	is_pausing = true
	$CenterContainer.visible = true
	$CenterContainer/vb/Resume.disabled = false
	$CenterContainer/vb/Return.disabled = false
	get_tree().paused = true
	var tween = Tween.new()
	add_child(tween)
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.connect("tween_all_completed",self,"pause_done")
	tween.interpolate_property(cc,"rect_scale",Vector2.ZERO,Vector2.ONE,0.4,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	tween.start()
	VisualServer.set_shader_time_scale(0)

func pause_done():
	is_pausing = false

func unpause():
	Global.in_game = true
	is_unpausing = true
	var tween = Tween.new()
	$CenterContainer/vb/Resume.disabled = true
	$CenterContainer/vb/Return.disabled = true
	add_child(tween)
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.connect("tween_all_completed",self,"unpause_done")
	tween.interpolate_property(cc,"rect_scale",Vector2.ONE,Vector2.ZERO,0.4,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	tween.start()

func unpause_done():
	is_unpausing = false
	get_tree().paused = false
	$CenterContainer.visible = false
	VisualServer.set_shader_time_scale(1)



func return_to_main():
	VisualServer.set_shader_time_scale(1)
	get_tree().paused = false
	cc.rect_scale = Vector2(0,0)
	cc.visible = false
	get_tree().change_scene("res://UI/MainMenu.tscn")
