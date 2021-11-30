extends Control

enum VCONTAINER{
	MAIN, #0
	ABOUT, #1
	ABOUTUS, #2
	CREDITS, #3
	MUSIC, #4
	SFX, #5
	PLAY, #6
	ART, #7
	SELECT, #8
	SETTINGS, #9
	
}

export var paja_texture_path : NodePath
export var petar_texture_path : NodePath
export var background_texture_path : NodePath
export var center_container_path : NodePath
export var menu_container_path : NodePath
export var about_container_path : NodePath
export var credits_container_path : NodePath
export var aboutus_container_path : NodePath
export var music_container_path : NodePath
export var sfx_container_path : NodePath
export var play_container_path : NodePath
export var art_container_path : NodePath
export var select_container_path : NodePath
export var settings_container_path : NodePath

onready var paja_texture : TextureRect = get_node(paja_texture_path)
onready var petar_texture : TextureRect = get_node(petar_texture_path)
onready var background_texture : TextureRect = get_node(background_texture_path)
onready var centerc : CenterContainer = get_node(center_container_path)
onready var mainc : VBoxContainer = get_node(menu_container_path)
onready var aboutc : VBoxContainer = get_node(about_container_path)
onready var creditsc : VBoxContainer = get_node(credits_container_path)
onready var aboutusc : VBoxContainer = get_node(aboutus_container_path)
onready var musicc : VBoxContainer = get_node(music_container_path)
onready var sfxc : VBoxContainer = get_node(sfx_container_path)
onready var playc : VBoxContainer = get_node(play_container_path)
onready var artc : VBoxContainer = get_node(art_container_path)
onready var selectc : VBoxContainer = get_node(select_container_path)
onready var settingsc : VBoxContainer = get_node(settings_container_path)

export var menu_offset : Vector2 = Vector2(0,120)

var visible_container : int = VCONTAINER.MAIN
var c : Array
var changing : bool = false
var ime : String = ""


func _ready() -> void:
	c = mainc.get_children()
	_update_visible()
	var mainmusic = preload("res://Sound/Music/LeBaguette-320bit.mp3")
	Music.stream = mainmusic
	Music.play()

func _input(event):
	if event is InputEventKey and event.pressed:
		var is_lowercase = (event.unicode >= ord('a') && event.unicode <= ord('z'))
		var is_uppercase = (event.unicode >= ord('A') && event.unicode <= ord('Z'))
		var is_digit = (event.unicode >= ord('0') && event.unicode <= ord('9'))
		var is_space = (event.unicode == ord(' '))
		if is_lowercase  || is_uppercase || is_digit || is_space:
			Global.ime += char(event.unicode)
			Global.ime = Global.ime.substr(0,12)
		elif event.scancode == 16777220:
			Global.ime = Global.ime.substr(0,max(0,Global.ime.length()-1))
	update()

func _draw():
	_draw_name()

func _draw_name():
	var screen_size : Vector2 = get_viewport_rect().size
	var mpos : Vector2 = get_viewport().get_mouse_position()
	var pos = Vector2(0.1,0.43)*screen_size-(screen_size/2-mpos)/40.0 + Vector2(100,370)
	if Global.ime == "":
		var strlen = get_font("").get_string_size("Type to insert name").x
		draw_string(get_font(""),pos-Vector2(strlen/2.0,0),"Type to insert name",Color(0.5,0.5,0.5))
	else:
		var strlen = get_font("").get_string_size(Global.ime).x
		draw_string(get_font(""),pos-Vector2(strlen/2.0,0),Global.ime)

func _process(delta) -> void:
	handle_menu_motion()
	handle_button_sizes(delta)

func handle_menu_motion() -> void:
	var screen_size : Vector2 = get_viewport_rect().size
	var mpos : Vector2 = get_viewport().get_mouse_position()
	petar_texture.rect_position = Vector2(0.1,0.43)*screen_size-(screen_size/2-mpos)/40.0 - Vector2(64,64)
	paja_texture.rect_position = Vector2(0.4,-0.13)*screen_size-(screen_size/2-mpos)/60.0 - Vector2(-64,64)
	background_texture.rect_position = -(screen_size/2-mpos)/100.0 - Vector2(64,64)
	centerc.rect_position = screen_size/2 - (screen_size/2-mpos)/12.0 + menu_offset

func handle_button_sizes(delta) -> void:
	for button in get_all_buttons(self):
		var new_scale : float 
		if not Input.get_mouse_button_mask() % 2 == 0:
			new_scale = 1.0 + int(button.get_global_rect().has_point(get_global_mouse_position()))*0.2
		else: new_scale = 1.0 + int(button.get_global_rect().has_point(get_global_mouse_position()))*0.4
		button.rect_scale = lerp(button.rect_scale,Vector2(new_scale,new_scale),10*delta)

func _update_visible() -> void:
	mainc.visible = visible_container == VCONTAINER.MAIN
	aboutc.visible = visible_container == VCONTAINER.ABOUT
	aboutusc.visible = visible_container == VCONTAINER.ABOUTUS
	creditsc.visible = visible_container == VCONTAINER.CREDITS
	musicc.visible = visible_container == VCONTAINER.MUSIC
	sfxc.visible = visible_container == VCONTAINER.SFX
	playc.visible = visible_container == VCONTAINER.PLAY
	artc.visible = visible_container == VCONTAINER.ART
	selectc.visible = visible_container == VCONTAINER.SELECT
	settingsc.visible = visible_container == VCONTAINER.SETTINGS
	_update_offset()

func _update_offset() -> void:
	match(visible_container):
		VCONTAINER.MAIN:
			menu_offset = Vector2(0,-10)
		
		VCONTAINER.ABOUT,VCONTAINER.ABOUTUS,VCONTAINER.CREDITS:
			menu_offset = Vector2(0,50)
		_:#VCONTAINER.MUSIC,VCONTAINER.SFX,VCONTAINER.PLAY:
			menu_offset = Vector2(0,40)

#------------MAIN MENU-------------------
	
func _on_Quit_pressed() -> void:
	get_tree().quit()

func change_menu(new_menu):
	if changing: return
	changing = true
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(centerc,"rect_scale",Vector2.ONE,Vector2.ZERO,0.2,Tween.TRANS_CUBIC,Tween.EASE_IN)
	tween.start()
	tween.connect("tween_all_completed",self,"on_menu_change",[new_menu])
	tween.connect("tween_all_completed",tween,"queue_free")
	
func on_menu_change(new_menu):
	visible_container = new_menu
	match new_menu:
		VCONTAINER.MAIN: c = mainc.get_children()
		VCONTAINER.PLAY: c = playc.get_children()
		VCONTAINER.ABOUT: c = aboutc.get_children()
		VCONTAINER.CREDITS: c = creditsc.get_children()
		VCONTAINER.MUSIC: c = musicc.get_children()
		VCONTAINER.ABOUTUS: c = aboutusc.get_children()
		VCONTAINER.SFX: c = sfxc.get_children()
		VCONTAINER.ART: c = artc.get_children()
		VCONTAINER.SELECT: c = selectc.get_children()
		VCONTAINER.SETTINGS: c = settingsc.get_children()
	_update_visible()
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(centerc,"rect_scale",Vector2.ZERO,Vector2.ONE,0.2,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tween.start()
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.connect("tween_all_completed",self,"set",["changing",false])


func get_all_buttons(node):
	var arr = []
	if node is Button: arr.append(node)
	for child in node.get_children():
		arr.append_array(get_all_buttons(child))
	return arr






func _on_New_Game_pressed():
	get_tree().change_scene("res://World/World.tscn")
