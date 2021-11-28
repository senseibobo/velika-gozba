extends Character

export var basic_attack_damage : float = 20.0
export var basic_attack_radius : float = 50.0
export var object_path : NodePath 
onready var object : Node2D = get_node(object_path)
onready var animationplayer : AnimationPlayer = object.get_node("AnimationPlayer")
onready var animationtree : AnimationNodeStateMachinePlayback = object.get_node("AnimationTree").get("parameters/playback")

var deflect_generator : BulletGenerator = BulletGenerator.new()

func _ready():
	Global.player = self
	deflect_generator.targets = deflect_generator.TARGETS.ENEMY
	add_child(deflect_generator)

func _process(delta):
	if animationtree.get_current_node() != "attack":
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
	match randi()%2:
		0: SFX.play_sound(SFX.TIGANJ1,0.45)
		1: SFX.play_sound(SFX.TIGANJ2,0.3)
	var pos = object.get_node("attack/vfx").global_position
	deflect_bullets(pos)
	hit_enemies(pos)

func deflect_bullets(pos):
	for bullet in Global.get_enemy_bullets():
		if bullet.position.distance_to(pos) < basic_attack_radius:
			bullet.velocity = -bullet.velocity
			bullet.generator.bullets.erase(bullet)
			bullet.current_time = 0
			var old_texture = bullet.texture
			var old_damage = bullet.damage
			deflect_generator.add_bullet(bullet)
			bullet.texture = old_texture
			

func hit_enemies(pos):
	for enemy in Global.enemies:
		if enemy.global_position.distance_to(pos) < basic_attack_radius:
			enemy.hit(basic_attack_damage,self)
