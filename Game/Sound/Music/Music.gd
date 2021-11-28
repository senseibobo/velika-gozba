extends AudioStreamPlayer

var mainmusic : AudioStream

func _ready() -> void:
	mainmusic = preload("res://Sound/Music/LeBaguette-320bit.mp3")
	stream = mainmusic
	play()
