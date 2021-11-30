extends VBoxContainer

func _ready():
	$Difficulty.text = "Difficulty: " + ["Easy","Medium","Hard"][Global.difficulty]


func increase_volume():
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus,AudioServer.get_bus_volume_db(bus)+5)

func decrease_volume():
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus,AudioServer.get_bus_volume_db(bus)-5)

func toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen


func toggle_shader():
	SWS.get_node("ColorRect").visible = !SWS.get_node("ColorRect").visible


func change_difficulty():
	Global.difficulty = (Global.difficulty + 1) % 3
	$Difficulty.text = "Difficulty: " + ["Easy","Medium","Hard"][Global.difficulty]
