extends CanvasLayer


export var cc_path : NodePath

onready var cc = get_node(cc_path)

func _ready():
	Global.in_game = false
	var tween = Tween.new()
	add_child(tween)
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.interpolate_property(cc,"rect_scale",Vector2.ZERO,Vector2.ONE,0.4,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	tween.start()
	$CenterContainer/vb/hb/vb2/ScoreAmount.text = str(LevelManager.score)


func _on_RestartLevel_pressed():
	get_tree().reload_current_scene()
	Global.in_game = true
