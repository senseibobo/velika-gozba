extends Character

export var basic_attack_damage : float = 20.0
export var basic_attack_radius : float = 120.0
export var object_path : NodePath 
onready var object : Node2D = get_node(object_path)
onready var animationplayer : AnimationPlayer = object.get_node("AnimationPlayer")
onready var animationtree : AnimationNodeStateMachinePlayback = object.get_node("AnimationTree").get("parameters/playback")

var deflect_generator : BulletGenerator = DeflectGenerator.new()
var frozen : bool = false

var is_attacking : bool = false
var is_pounding : bool = false


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
	if animationtree.get_current_node() in ["run","idle","RESET"]:
		_handle_movement()

func _process(delta):
	if frozen: return
	if animationtree.get_current_node() in ["run","idle","RESET"]:
		_handle_animations()
		_handle_attacking()

		
func _handle_attacking():
	if is_attacking:
		animationtree.travel("attack")
	elif is_pounding:
		animationtree.travel("pound")
		$CollisionShape2D.set_deferred("disabled",true)


func _handle_movement():
	var _hmove = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var _vmove = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	var _dir = Vector2(_hmove,_vmove).normalized()
	move_and_slide(_dir*movement_speed)

func _handle_animations():
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		return
	elif Input.is_action_just_pressed("pound"):
		is_pounding = true
		return
	var _hmove = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var _vmove = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	var _dir = Vector2(_hmove,_vmove).normalized()
	if !is_zero_approx(_dir.x):
		object.scale.x = sign(_dir.x)*abs(object.scale.x)
	if _dir != Vector2():
		animationtree.travel("run")
	else:
		animationtree.travel("idle")

func attack():
	is_attacking = false
	is_pounding = false
	var pos = object.get_node("attack/tiganj").global_position
	var deflected = deflect_bullets(pos)
	hit_enemies(pos,basic_attack_radius)
	if deflected: 
		SFX.play_sound(SFX.DEFLECT)
	else: SFX.play_sound(SFX.TIGANJ1 + randi()%2)

func pound():
	is_attacking = false
	is_pounding = false
	$CollisionShape2D.set_deferred("disabled",false)
	SFX.play_sound(SFX.SERPA)
	hit_enemies(global_position,basic_attack_radius*2.0,basic_attack_damage*1.5)
	animationtree.travel("stagger")

func deflect_bullets(pos):
	var deflected = false
	for bullet in Global.get_enemy_bullets():
		if bullet.position.distance_to(pos) < basic_attack_radius:
			bullet.generator.bullets.erase(bullet)
			deflect_generator.add_bullet(bullet)
			deflected = true
			LevelManager.add_score_multiplier(0.01)
	return deflected
			

func hit_enemies(pos,radius,damage = basic_attack_damage):
	for enemy in Global.enemies:
		if not is_instance_valid(enemy): continue
		if enemy.global_position.distance_to(pos) < radius + enemy.hitbox_radius:
			enemy.hit(damage,self)

func hit(damage,source):
	if frozen or animationtree.get_current_node() in ["pound"]: return false
	LevelManager.score_multiplier = 1.0
	damage *= 1+Global.difficulty/4.0
	if animationtree.get_current_node() in ["run","idle","RESET"]: 
		animationtree.travel("stagger")
	.hit(damage,source)
	SFX.play_sound(SFX.PLAYERHIT1 + randi()%3)
	return true

func death(source):
	var deathscreen = preload("res://UI/FinishLevel/DeathScreen.tscn").instance()
	get_tree().current_scene.add_child(deathscreen)
	animationtree.travel("death")
	frozen = true
	#play animation
