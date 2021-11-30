extends Node2D


func _ready():
	LevelManager.start_level()
	Global.in_game = true
