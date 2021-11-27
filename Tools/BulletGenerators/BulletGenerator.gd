extends Node2D
class_name BulletGenerator

var bullets : Array

export var life_time : float = 3.0
export var bullet_script : GDScript = preload("res://Tools/Bullets/Bullet.gd")
export var texture : Texture
export var bullet_size : Vector2

var multimeshinstance : MultiMeshInstance2D = MultiMeshInstance2D.new()
var multimesh = MultiMesh.new()
var mesh : QuadMesh = QuadMesh.new()

func _ready():
	multimesh.mesh = mesh
	multimeshinstance.texture = texture
	multimeshinstance.multimesh = multimesh
	mesh.size = bullet_size
	add_child(multimeshinstance)
	multimeshinstance.set_as_toplevel(true)

func add_bullet(bullet):
	bullets.append(bullet)
	multimesh.instance_count = bullets.size()
	_update_bullet_positions()

func remove_bullet(bullet):
	if bullet is Bullet: bullets.erase(bullet)
	else: bullet.remove(bullet)
	multimesh.instance_count = bullets.size()
	_update_bullet_positions()

func _process(delta):
	_debug_process(delta)
	_process_bullets(delta)
	_update_bullet_positions()

var time = 0.0

func _debug_process(delta):
	var bullet = Bullet.new()
	bullet.position = global_position
	bullet.velocity = Vector2.RIGHT.rotated(time)*100.0
	bullet.rotation = time
	bullet.life_time = life_time
	add_bullet(bullet)
	time += delta*20.0

func _process_bullets(delta):
	var erased_bullets : Array = []
	for bullet in bullets:
		bullet._process(delta)
		if bullet.current_time > bullet.life_time:
			erased_bullets.append(bullet)
	for bullet in erased_bullets:
		remove_bullet(bullet)

func _update_bullet_positions():
	for i in range(bullets.size()):
		var t = Transform2D(bullets[i].rotation,bullets[i].position)
		multimesh.set_instance_transform_2d(i,t)

func shoot():
	pass

