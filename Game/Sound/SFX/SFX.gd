extends Node

enum {
	TIGANJ1,
	TIGANJ2,
	DEFLECT,
	PLAYERHIT1,
	PLAYERHIT2,
	PLAYERHIT3,
	PARADAJZDEATH,
	PARADAJZSMESAK,
	KROMPIRSMESAK,
	KROMPIRSMRT,
	LUKSMESAK,
	LUKSMRT,
	LUKEKSPLOZIJA,
}

var sfx = [
	preload("res://Sound/SFX/tiganj1.ogg"),
	preload("res://Sound/SFX/tiganj2.ogg"),
	preload("res://Sound/SFX/deflect.ogg"),
	preload("res://Sound/SFX/bol1.ogg"),
	preload("res://Sound/SFX/bol2.ogg"),
	preload("res://Sound/SFX/bol3.ogg"),
	preload("res://Sound/SFX/paradajz smrt.ogg"),
	preload("res://Sound/SFX/paradajz smesak.ogg"),
	preload("res://Sound/SFX/KrompirSmesak.ogg"),
	preload("res://Sound/SFX/KrompirSmrt1.ogg"),
	preload("res://Sound/SFX/LukSmesak.ogg"),
	preload("res://Sound/SFX/LukSmrt.ogg"),
	preload("res://Sound/SFX/LukEksplozija.ogg"),
]

func play_sound(sound, from = 0.0):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = sfx[sound]
	audio_player.play(from)
	audio_player.connect("finished",audio_player,"queue_free")
