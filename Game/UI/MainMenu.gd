extends Control

enum VCONTAINER{
	MAIN,
	ABOUT,
	ABOUTUS,
	CREDITS,
	MUSIC,
	SFX,
	PLAY
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

export var menu_offset : Vector2 = Vector2(0,120)

var visible_container : int = VCONTAINER.MAIN
var c : Array

func _ready() -> void:
	c = mainc.get_children()
	_update_visible()

func _process(delta) -> void:
	var screen_size : Vector2 = get_viewport_rect().size
	var mpos : Vector2 = get_viewport().get_mouse_position()
	petar_texture.rect_position = Vector2(0.1,0.43)*screen_size-(screen_size/2-mpos)/40.0 - Vector2(64,64)
	paja_texture.rect_position = Vector2(0.4,-0.13)*screen_size-(screen_size/2-mpos)/60.0 - Vector2(-64,64)
	background_texture.rect_position = -(screen_size/2-mpos)/100.0 - Vector2(64,64)
	centerc.rect_position = screen_size/2 - (screen_size/2-mpos)/12.0 + menu_offset
	for button in c:
		if not button is Button: continue
		var new_scale : float = 1.0 + int(button.get_global_rect().has_point(get_global_mouse_position()))*0.4
		button.rect_scale = lerp(button.rect_scale,Vector2(new_scale,new_scale),10*delta)

func _update_visible() -> void:
	mainc.visible = visible_container == VCONTAINER.MAIN
	aboutc.visible = visible_container == VCONTAINER.ABOUT
	aboutusc.visible = visible_container == VCONTAINER.ABOUTUS
	creditsc.visible = visible_container == VCONTAINER.CREDITS
	musicc.visible = visible_container == VCONTAINER.MUSIC
	sfxc.visible = visible_container == VCONTAINER.SFX
	playc.visible = visible_container == VCONTAINER.PLAY
	_update_offset()

func _update_offset() -> void:
	match(visible_container):
		VCONTAINER.MAIN:
			menu_offset = Vector2(0,-10)
		
		VCONTAINER.ABOUT,VCONTAINER.ABOUTUS,VCONTAINER.CREDITS:
			menu_offset = Vector2(0,50)
		VCONTAINER.MUSIC,VCONTAINER.SFX,VCONTAINER.PLAY:
			menu_offset = Vector2(0,40)

#------------MAIN MENU-------------------
func _on_Play_pressed():
	visible_container = VCONTAINER.PLAY
	c = playc.get_children()
	_update_visible()
	
func _on_About_pressed() -> void:
	visible_container = VCONTAINER.ABOUT
	c = aboutc.get_children()
	_update_visible()
	
func _on_Quit_pressed() -> void:
	get_tree().quit()
#------------PLAY-----------------------
func _on_PlayBack_pressed():
	visible_container = VCONTAINER.MAIN
	c = mainc.get_children()
	_update_visible()
#------------ABOUT-----------------------
func _on_Credits_pressed() -> void:
	visible_container = VCONTAINER.CREDITS
	c = creditsc.get_children()
	_update_visible()

func _on_About_Us_pressed() -> void:
	visible_container = VCONTAINER.ABOUTUS
	c = aboutusc.get_children()
	_update_visible()

func _on_Back_pressed() -> void:
	visible_container = VCONTAINER.MAIN
	c = mainc.get_children()
	_update_visible()
#------------CREDITS----------------------
func _on_Music_pressed() -> void:
	visible_container = VCONTAINER.MUSIC
	c = musicc.get_children()
	_update_visible()

func _on_SFX_pressed() -> void:
	visible_container = VCONTAINER.SFX
	c = sfxc.get_children()
	_update_visible()

func _on_CreditsBack_pressed() -> void:
	visible_container = VCONTAINER.ABOUT
	c = aboutc.get_children()
	_update_visible()
#------------MUSIC----------------------
func _on_MusicBack_pressed() -> void:
	visible_container = VCONTAINER.CREDITS
	c = creditsc.get_children()
	_update_visible()
#------------SFX----------------------
func _on_SFXBack_pressed() -> void:
	visible_container = VCONTAINER.CREDITS
	c = creditsc.get_children()
	_update_visible()
#------------ABOUTUS----------------------
func _on_AboutUsBack_pressed() -> void:
	visible_container = VCONTAINER.ABOUT
	c = aboutc.get_children()
	_update_visible()






