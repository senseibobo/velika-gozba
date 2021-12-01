extends Node

var score_multiplier : float = 1.0
var score : float = 0.0
var level : int = 1
var score_timer : float = 5.0
var score_drop_time : float = 5.0

const level_count : int = 4

const music_names_per_level = [
	"byebyebrain",
	"sillyintro",
	"countdown",
	"thegreatbattle"
]

const music_per_level = [
	preload("res://Sound/Music/ByeByeBrain320bit.mp3"),
	preload("res://Sound/Music/alexander-nakarada-silly-intro.mp3"),
	preload("res://Sound/Music/Countdown.ogg"),
	preload("res://Sound/Music/alexander-nakarada-the-great-battle.mp3")
]

func add_score(amount):
	score += amount*score_multiplier
	score_timer = score_drop_time

func add_score_multiplier(amount):
	score_multiplier += amount
	score_timer = score_drop_time

func _process(delta):
	score_timer -= delta
	if score_timer <= 0:
		score_multiplier = 1.0

func start_level():
	score = 0
	Music.play_music(music_names_per_level[level-1],music_per_level[level-1])
	var level_scene : Node = load("res://Levels/Level"+str(level)+".tscn").instance()
	var tilemap : TileMap = level_scene.get_node("TileMap")
	var elements : Node = level_scene.get_node("Elements")
	var finish : Area2D = level_scene.get_node_or_null("LevelFinish")
	tilemap.z_index = -20
	level_scene.remove_child(tilemap)
	get_tree().current_scene.add_child(tilemap)
	for element in elements.get_children():
		elements.remove_child(element)
		get_tree().current_scene.get_node("YSort").add_child(element)
	if finish != null:
		level_scene.remove_child(finish)
		get_tree().current_scene.add_child(finish)
		finish.connect("body_entered",self,"finish_level")

func finish_level(body) -> void:
	LevelManager.level += 1
	Save.save_game()
	Global.player.frozen = true
	Global.player.animationtree.travel("idle")
	Web.send_highscore(level,score,self,"on_highscore_received")

func on_highscore_received(result, response_code, headers, body) -> void:
	var level_complete = preload("res://UI/FinishLevel/FinishLevel.tscn").instance()
	Global.in_game = false
	get_tree().current_scene.add_child(level_complete)
