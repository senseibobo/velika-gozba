extends Node

enum TARGETS {
	PLAYER,
	ENEMY
}
enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

var player : Node2D
var enemies : Array

var enemy_generators : Array
var player_generators : Array

var ime : String = ""
var in_game : bool = false
var in_menu : bool = false


var difficulty : int = 1
var volume : float = 0.0

func get_all_bullets() -> Array:
	var arr : Array = []
	arr.append_array(get_player_bullets())
	arr.append_array(get_enemy_bullets())
	return arr

func get_player_bullets() -> Array:
	var arr : Array = []
	update_player_generators()
	for gen in player_generators: arr.append_array(gen.bullets)
	return arr

func get_enemy_bullets() -> Array:
	var arr : Array = []
	update_enemy_generators()
	for gen in enemy_generators:
		if is_instance_valid(gen):
			arr.append_array(gen.bullets)
	return arr

func update_player_generators() -> void:
	for gen in player_generators:
		if !is_instance_valid(gen):
			player_generators.erase(gen)

func update_enemy_generators() -> void:
	for gen in enemy_generators:
		if !is_instance_valid(gen):
			enemy_generators.erase(gen)
		


