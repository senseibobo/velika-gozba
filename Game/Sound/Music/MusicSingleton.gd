extends AudioStreamPlayer

var mainmusic : AudioStreamPlayer

func _ready() -> void:
	mainmusic = preload("res://Sound/Music/MusicSingleton.tscn").instance()
	add_child(mainmusic)
	mainmusic.play()

func _music_stop() -> void:
	mainmusic.stop()
