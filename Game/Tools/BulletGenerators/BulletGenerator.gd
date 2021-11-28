extends Node2D
class_name BulletGenerator


enum TARGETS {
	PLAYER,
	ENEMY
}

export var shot_interval : float = 0.1
export var speed : float = 100.0
export var life_time : float = 3.0
export var bullet_script : GDScript = preload("res://Tools/Bullets/Bullet.gd")
export var texture : Texture = preload("res://icon.png")
export var bullet_size : Vector2 = Vector2(8,8)
export var bullet_radius  : float = 8.0
export(TARGETS) var targets : int = TARGETS.PLAYER

var multimeshinstance : MultiMeshInstance2D = MultiMeshInstance2D.new()
var multimesh = MultiMesh.new()
var mesh : QuadMesh = QuadMesh.new()
var time : float = 0.0
var bullets : Array

func _ready() -> void:
	multimesh.mesh = mesh
	multimeshinstance.texture = texture
	multimeshinstance.multimesh = multimesh
	mesh.size = bullet_size
	add_child(multimeshinstance)
	multimeshinstance.set_as_toplevel(true)
	multimeshinstance.z_index = -5
	match targets:
		TARGETS.ENEMY: Global.player_generators.append(self)
		TARGETS.PLAYER: Global.enemy_generators.append(self)
	
func _process(delta) -> void:
	_process_shooting(delta)
	_process_bullets(delta)
	_update_bullet_positions()

func add_bullet(bullet) -> void:
	bullet.generator = self
	bullets.append(bullet)
	multimesh.instance_count = bullets.size()
	_update_bullet_positions()

func remove_bullet(bullet) -> void:
	if bullet is Bullet: bullets.erase(bullet)
	else: bullet.remove(bullet)
	multimesh.instance_count = bullets.size()
	_update_bullet_positions()

func _process_shooting(delta) -> void:
	time += delta
	while time > shot_interval:
		shoot()
		time -= shot_interval

func _process_bullets(delta) -> void:
	var erased_bullets : Array = []
	for bullet in bullets:
		bullet._process(delta)
		if bullet.check_collision(bullet_radius,targets) or bullet.current_time > bullet.life_time:
			erased_bullets.append(bullet)
	for bullet in erased_bullets:
		remove_bullet(bullet)

func _update_bullet_positions() -> void:
	for i in range(bullets.size()):
		var t : Transform2D = Transform2D(bullets[i].rotation,bullets[i].position)
		multimesh.set_instance_transform_2d(i,t)

func shoot() -> void:
	pass

