extends Node

const default_values = {
	"fullscreen" : false,
	"difficulty" : Global.DIFFICULTY.MEDIUM,
	"volume" : -15,
	"name" : "",
	"level" : 1
}


func _ready():
	load_game()

func get_save_dict():
	var save_dict = {
		"fullscreen" : OS.window_fullscreen,
		"difficulty" : Global.difficulty,
		"volume" : Global.volume,
		"name" : Global.ime,
		"level" : LevelManager.level
	}
	return save_dict

func save_game():
	var save_dict = get_save_dict()
	var file = File.new()
	var json = JSON.print(save_dict)
	file.open("user://save.json",file.WRITE)
	file.store_string(json)
	file.close()

func load_game():
	var file = File.new()
	var err = file.open("user://save.json",file.READ)
	if err:
		apply_save(default_values)
		return
	var text = file.get_as_text()
	file.close()
	var json = JSON.parse(text).result
	apply_save(json)
	

func apply_save(save_dict):
	OS.window_fullscreen = save_dict["fullscreen"]
	Global.difficulty = save_dict["difficulty"]
	Global.volume = save_dict["volume"]
	Global.ime = save_dict["name"]
	LevelManager.level = save_dict["level"]
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus,Global.volume)
	Save.save_game()
	
	
