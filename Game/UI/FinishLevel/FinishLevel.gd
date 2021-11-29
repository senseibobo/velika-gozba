extends Control


export var cc_path : NodePath
export var highscores_path : NodePath

onready var cc = get_node(cc_path)
onready var highscores_node = get_node(highscores_path)

func _ready():
	Web.request_highscores(self,"on_highscores_received")

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
