extends AudioStreamPlayer

var mainmusic : AudioStream
var current_song : String
var looping : bool = false

func play_music(song_name : String, song_stream : AudioStream, from_position : float = 0.0):
	stream = song_stream
	current_song = song_name
	play(from_position)

func _process(delta):
	if playing and looping:
		var npos : float = 0.0
		var lpos : float = 1000.0
		match current_song:
			"lebaguette":
				npos = 0.0
				lpos = 49.639
			"sillyintro": 
				npos = 6.348
				lpos = 23.704
			"byebyebrain":
				npos = 0.0
				lpos = 221.088
		if get_playback_position() > lpos:
			play(npos)
				
	
	
