extends Node


enum {
	TIGANJ1,
	TIGANJ2,
	PARADAJZ_DEATH,
	PARADAJZ_SMESAK,
	DEFLECT
}

var sfx = [
	preload("res://Sound/SFX/tiganj1.ogg"),
	preload("res://Sound/SFX/tiganj2.ogg"),
	preload("res://Sound/SFX/paradajz smrt.ogg"),
	preload("res://Sound/SFX/paradajz smesak.ogg"),
	preload("res://Sound/SFX/deflect.ogg")
]

func play_sound(sound, from = 0.0):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = sfx[sound]
	audio_player.play(from)
	audio_player.connect("finished",audio_player,"queue_free")
