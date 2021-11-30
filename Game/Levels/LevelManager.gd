extends Node

var score : float = 200.0
var level : int = 1

const level_count : int = 1

func start_level():
	var level_scene = load("res://Levels/Level"+str(level)+".tscn").instance()
	var tilemap = level_scene.get_node("TileMap")
	var elements = level_scene.get_node("Elements")
	var finish : Area2D = level_scene.get_node("LevelFinish")
	tilemap.z_index = -20
	level_scene.remove_child(tilemap)
	get_tree().current_scene.add_child(tilemap)
	for element in elements.get_children():
		elements.remove_child(element)
		get_tree().current_scene.get_node("YSort").add_child(element)
	level_scene.remove_child(finish)
	get_tree().current_scene.add_child(finish)
	finish.connect("body_entered",self,"finish_level")

func finish_level(body):
	Global.player.frozen = true
	Global.player.animationtree.travel("idle")
	Web.send_highscore(level,score,self,"on_highscore_received")

func on_highscore_received(result, response_code, headers, body):
	var level_complete = preload("res://UI/FinishLevel/FinishLevel.tscn").instance()
	Global.in_game = false
	get_tree().current_scene.add_child(level_complete)
