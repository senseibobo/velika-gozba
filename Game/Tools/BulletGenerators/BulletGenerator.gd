extends Node2D
class_name BulletGenerator

signal shot


enum TARGETS {
	PLAYER,
	ENEMY
}

export var damage : float = 20
export var count : int = 1
export var shot_interval : float = 0.1
export var speed : float = 100.0
export var life_time : float = 3.0
export var bullet_script : GDScript = preload("res://Tools/Bullets/Bullet.gd")
export var texture : Texture = preload("res://icon.png")
export var bullet_size : Vector2 = Vector2(8,8)
export var bullet_radius  : float = 32.0
export var shooting : bool = true setget set_shooting
export var shot_delay : float = 0.0
export(TARGETS) var targets : int = TARGETS.PLAYER

var multimeshinstance : MultiMeshInstance2D = MultiMeshInstance2D.new()
var multimesh = MultiMesh.new()
var mesh : QuadMesh = QuadMesh.new()
var time : float = 0.0
var bullets : Array

func set_shooting(value):
	shooting = value
	time = 0

func _ready() -> void:
	add_to_generator_array()

func add_to_generator_array():
	match targets:
		TARGETS.ENEMY: Global.player_generators.append(self)
		TARGETS.PLAYER: Global.enemy_generators.append(self)
	
func _process(delta) -> void:
	_process_shooting(delta)
	_process_bullets(delta)

func add_bullet(bullet):
	bullet.texture = texture
	bullet.life_time = life_time
	bullet.generator = self
	bullet.size = bullet_size
	bullet.damage = damage
	bullets.append(bullet)
	return bullet

func remove_bullet(bullet) -> void:
	if bullet is Bullet: bullets.erase(bullet)
	else: bullet.remove(bullet)

func _process_shooting(delta) -> void:
	time += delta
	while shooting and time > shot_interval:
		time -= shot_interval
		for i in count:
			if shooting:
				shoot()
				if shot_delay != 0.0:
					yield(get_tree().create_timer(shot_delay),"timeout")

func _process_bullets(delta) -> void:
	var erased_bullets : Array = []
	for bullet in bullets:
		bullet._process(delta)
		if bullet.check_collision(bullet_radius,targets) or bullet.current_time > bullet.life_time:
			erased_bullets.append(bullet)
	for bullet in erased_bullets:
		remove_bullet(bullet)
	update()

func _draw():
	_draw_bullets()

func _draw_bullets():
	for bullet in bullets:
		var rect = Rect2()
		rect.size = bullet.size
		rect.position = Vector2()
		var pos = bullet.position
		var rot = bullet.rotation
		draw_set_transform(pos - rect.size.rotated(rot)/2-global_position,rot,Vector2(1,1))
		draw_texture_rect(bullet.texture,rect,false)
		draw_set_transform(Vector2(),0,Vector2(1,1))


func shoot() -> void:
	pass

