extends Character

export var basic_attack_damage : float = 20.0
export var basic_attack_radius : float = 100.0
export var object_path : NodePath 
onready var object : Node2D = get_node(object_path)
onready var animationplayer : AnimationPlayer = object.get_node("AnimationPlayer")
onready var animationtree : AnimationNodeStateMachinePlayback = object.get_node("AnimationTree").get("parameters/playback")

var deflect_generator : BulletGenerator = DeflectGenerator.new()
var frozen : bool = false


func _ready():
	var camera = WorldCamera.new()
	camera.target_node = self
	add_child(deflect_generator)
	Global.player = self
	var hud = preload("res://UI/HUD/HUD.tscn").instance()
	get_tree().current_scene.call_deferred("add_child",hud)
	get_tree().current_scene.call_deferred("add_child",camera)


func _physics_process(delta):
	if frozen: return
	if animationtree.get_current_node() in ["run","idle"]:
		_handle_movement()
		_handle_animations()
	_handle_attack()
	

func _handle_movement():
	var _hmove = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var _vmove = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	var _dir = Vector2(_hmove,_vmove).normalized()
	move_and_slide(_dir*movement_speed)

func _handle_animations():
	var _hmove = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var _vmove = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	var _dir = Vector2(_hmove,_vmove).normalized()
	if !is_zero_approx(_dir.x):
		object.scale.x = sign(_dir.x)*abs(object.scale.x)
	if _dir != Vector2():
		animationtree.travel("run")
	else:
		animationtree.travel("idle")

func _handle_attack():
	if Input.is_action_just_pressed("attack"):
		animationtree.travel("attack")

func attack():
	var pos = object.get_node("attack/tiganj").global_position
	var deflected = deflect_bullets(pos)
	hit_enemies(pos)
	if deflected: SFX.play_sound(SFX.DEFLECT)
	else: SFX.play_sound(SFX.TIGANJ1 + randi()%2)

func deflect_bullets(pos):
	var deflected = false
	for bullet in Global.get_enemy_bullets():
		if bullet.position.distance_to(pos) < basic_attack_radius:
			bullet.generator.bullets.erase(bullet)
			deflect_generator.add_bullet(bullet)
			deflected = true
	return deflected
			

func hit_enemies(pos):
	for enemy in Global.enemies:
		if not is_instance_valid(enemy): continue
		if enemy.global_position.distance_to(pos) < basic_attack_radius + enemy.hitbox_radius:
			enemy.hit(basic_attack_damage,self)

func hit(damage,source):
	if animationtree.get_current_node() == "stagger": return
	elif animationtree.get_current_node() in ["run","idle"]: animationtree.travel("stagger")
	.hit(damage,source)
	SFX.play_sound(SFX.PLAYERHIT1 + randi()%3)
