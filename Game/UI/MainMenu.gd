extends Control

enum VCONTAINER{
	MAIN,
	ABOUT,
	ABOUTUS,
	CREDITS,
	MUSIC,
	SFX,
}
export var center_container_path : NodePath
export var menu_cointaner_path : NodePath
export var about_cointaner_path : NodePath
export var credits_cointaner_path : NodePath
export var aboutus_cointaner_path : NodePath
export var music_cointaner_path : NodePath
export var sfx_cointaner_path : NodePath

onready var centerc : CenterContainer = get_node(center_container_path)
onready var mainc : VBoxContainer = get_node(menu_cointaner_path)
onready var aboutc : VBoxContainer = get_node(about_cointaner_path)
onready var creditsc : VBoxContainer = get_node(credits_cointaner_path)
onready var aboutusc : VBoxContainer = get_node(aboutus_cointaner_path)
onready var musicc : VBoxContainer = get_node(music_cointaner_path)
onready var sfxc : VBoxContainer = get_node(sfx_cointaner_path)

export var menu_offset : Vector2 = Vector2(0,120)

var visible_container : int = VCONTAINER.MAIN
var c : Array

func _ready() -> void:
	c = mainc.get_children()
	_update_visible()

func _process(delta) -> void:
	var screen_size : Vector2 = get_viewport_rect().size
	var mpos : Vector2 = get_viewport().get_mouse_position()
	centerc.rect_position = screen_size/2 - (screen_size/2-mpos)/16.0 + menu_offset
	for button in c:
		var new_scale : float = 1.0 + int(button.get_global_rect().has_point(get_global_mouse_position()))*0.4
		button.rect_scale = lerp(button.rect_scale,Vector2(new_scale,new_scale),10*delta)

func _update_visible() -> void:
	mainc.visible = visible_container == VCONTAINER.MAIN
	aboutc.visible = visible_container == VCONTAINER.ABOUT
	aboutusc.visible = visible_container == VCONTAINER.ABOUTUS
	creditsc.visible = visible_container == VCONTAINER.CREDITS
	musicc.visible = visible_container == VCONTAINER.MUSIC
	sfxc.visible = visible_container == VCONTAINER.SFX
	_update_offset()

func _update_offset() -> void:
	match(visible_container):
		VCONTAINER.MAIN,VCONTAINER.ABOUT,VCONTAINER.ABOUTUS,VCONTAINER.CREDITS:
			menu_offset = Vector2(0,120)
		VCONTAINER.MUSIC,VCONTAINER.SFX:
			menu_offset = Vector2(0,50)

#------------MAIN MENU-------------------
func _on_About_pressed() -> void:
	visible_container = VCONTAINER.ABOUT
	c = aboutc.get_children()
	_update_visible()
	
func _on_Quit_pressed() -> void:
	get_tree().quit()
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
	#c = musicc.get_children()
	_update_visible()

func _on_SFX_pressed() -> void:
	visible_container = VCONTAINER.SFX
	#c = sfxc.get_children()
	_update_visible()

func _on_CreditsBack_pressed() -> void:
	visible_container = VCONTAINER.ABOUT
	_update_visible()
#------------MUSIC----------------------
func _on_MusicBack_pressed() -> void:
	visible_container = VCONTAINER.CREDITS
	_update_visible()
#------------SFX----------------------
func _on_SFXBack_pressed() -> void:
	visible_container = VCONTAINER.CREDITS
	_update_visible()
#------------ABOUTUS----------------------
func _on_AboutUsBack_pressed() -> void:
	visible_container = VCONTAINER.ABOUT
	_update_visible()


