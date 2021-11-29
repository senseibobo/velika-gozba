extends Node


func start_level(level : int):
	var level_scene = load("res://Levels/Level"+str(level)+".tscn").instance()
	var tilemap = level_scene.get_node("TileMap")
	var elements = level_scene.get_node("Elements")
	tilemap.z_index = -20
	level_scene.remove_child(tilemap)
	get_tree().current_scene.add_child(tilemap)
	for element in elements.get_children():
		elements.remove_child(element)
		get_tree().current_scene.get_node("YSort").add_child(element)
