extends VBoxContainer

func _ready():
	$Difficulty.text = "Difficulty: " + ["Easy","Medium","Hard"][Global.difficulty]
	var bus = AudioServer.get_bus_index("Master")


func increase_volume():
	var bus = AudioServer.get_bus_index("Master")
	Global.volume += 5
	AudioServer.set_bus_volume_db(bus,Global.volume)
	Save.save_game()

func decrease_volume():
	var bus = AudioServer.get_bus_index("Master")
	Global.volume -= 5
	AudioServer.set_bus_volume_db(bus,Global.volume)
	Save.save_game()

func toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
	Save.save_game()


func toggle_shader():
	SWS.get_node("ColorRect").visible = !SWS.get_node("ColorRect").visible


func change_difficulty():
	Global.difficulty = (Global.difficulty + 1) % 3
	$Difficulty.text = "Difficulty: " + ["Easy","Medium","Hard"][Global.difficulty]
	Save.save_game()
