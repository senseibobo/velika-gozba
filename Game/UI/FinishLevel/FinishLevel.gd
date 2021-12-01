extends CanvasLayer


export var cc_path : NodePath
export var highscores_path : NodePath

onready var cc = get_node(cc_path)
onready var highscores_node = get_node(highscores_path)

func _ready():
	var tween = Tween.new()
	add_child(tween)
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.interpolate_property(cc,"rect_scale",Vector2.ZERO,Vector2.ONE,0.4,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	tween.start()
	Web.request_highscores(LevelManager.level,self,"on_highscores_received")
	if LevelManager.level > LevelManager.level_count:
		$CenterContainer/vb/LevelComplete.text = "Well Done!"
		$CenterContainer/vb/NextLevel.text = "Return to menu"
		$CenterContainer/vb/NextLevel.disconnect("pressed",self,"_on_NextLevel_pressed")
		$CenterContainer/vb/NextLevel.connect("pressed",get_tree(),"change_scene",["res://UI/MainMenu.tscn"])
		

func on_highscores_received(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var highscores = json.result
	if highscores.size() <= 0:
		get_node("CenterContainer/vb/Loading").text = "No highscores found"
	else:
		get_node("CenterContainer/vb/Loading").visible = false
		for highscore in highscores:
			var name_node = highscores_node.get_node("names/Name").duplicate()
			name_node.visible = true
			name_node.text = highscore.name
			highscores_node.get_node("names").add_child(name_node)
			var highscore_node = highscores_node.get_node("highscores/Highscore").duplicate()
			highscore_node.visible = true
			highscore_node.text = str(highscore.score)
			highscores_node.get_node("highscores").add_child(highscore_node)
	$CenterContainer/vb/hb/vb2/ScoreAmount.text = str(LevelManager.score)


func _on_NextLevel_pressed():
	get_tree().reload_current_scene()
