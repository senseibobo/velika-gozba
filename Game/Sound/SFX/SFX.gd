extends Node

enum {
	TIGANJ1,
	TIGANJ2,
	DEFLECT,
	PLAYERHIT1,
	PLAYERHIT2,
	PLAYERHIT3,
}

var sfx = [
	preload("res://Sound/SFX/tiganj1.ogg"),
	preload("res://Sound/SFX/tiganj2.ogg"),
	preload("res://Sound/SFX/deflect.ogg"),
	preload("res://Sound/SFX/bol1.ogg"),
	preload("res://Sound/SFX/bol2.ogg"),
	preload("res://Sound/SFX/bol3.ogg"),
]

func play_sound(sound, from = 0.0):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	if sound == null: return
	elif sound is AudioStream: audio_player.stream = sound;
	else: audio_player.stream = sfx[sound]
	audio_player.play(from)
	audio_player.connect("finished",audio_player,"queue_free")
