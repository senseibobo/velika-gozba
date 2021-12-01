extends GridContainer

func _ready():
	for i in LevelManager.level_count:
		pass
		var button = Button.new()
		button.text = str(i+1)
		button.connect("pressed",self,"on_level_selected",[i+1])
		button.rect_min_size = Vector2(64,64)
		button.rect_pivot_offset = Vector2(32,32)
		add_child(button)
	
func on_level_selected(level):
	LevelManager.level = level
	get_tree().change_scene("res://World/World.tscn")
	Global.in_menu = false
	pass
