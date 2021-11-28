extends Node

enum TARGETS {
	PLAYER,
	ENEMY
}

var player : Node2D
var enemies : Array

var enemy_generators : Array
var player_generators : Array


func get_all_bullets():
	var arr = []
	arr.append_array(get_player_bullets())
	arr.append_array(get_enemy_bullets())
	return arr

func get_player_bullets():
	var arr = []
	update_player_generators()
	for gen in player_generators: arr.append_array(gen.bullets)
	return arr

func get_enemy_bullets():
	var arr = []
	update_enemy_generators()
	for gen in enemy_generators: arr.append_array(gen.bullets)
	return arr

func update_player_generators():
	for gen in player_generators:
		if !is_instance_valid(gen):
			player_generators.erase(gen)

func update_enemy_generators():
	for gen in enemy_generators:
		if !is_instance_valid(gen):
			enemy_generators.erase(gen)
		


