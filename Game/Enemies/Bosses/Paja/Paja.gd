extends Boss

var attack_timer : float = 2.0
var attack_cooldown : float = 1.5
var attacking : bool = false
var current_attack : int = -1
var rand_location : Vector2

onready var animationplayer : AnimationPlayer = $Sprite/AnimationPlayer

func _ready():
	
	animationplayer.play("idle")

func _process(delta):
	$CanvasLayer/Healthbar.material.set_shader_param("health_percentage",health/max_health)
	attack_timer -= delta
	if attacking:
		match current_attack:
			0: _process_attack1(delta)
			1: _process_attack2(delta)
			2: _process_attack3(delta)
	elif attack_timer <= 0:
		attack()
	
func _physics_process(delta):
	if attacking:
		match current_attack:
			0: _physics_process_attack1(delta)
			1: _physics_process_attack2(delta)

func attack():
	current_attack = 2 if current_attack == -1 else (current_attack+1+randi()%2)%3
	attacking = true
	animationplayer.play(str(current_attack+1)+"napad")
	rand_location = Vector2(rand_range(-440,1270),rand_range(-700,-200))
	if current_attack == 2:
		global_position = Vector2(Global.player.global_position.x, -700)
		

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ["1napad","2napad","3napad"]:
		attacking = false
		attack_timer = attack_cooldown
		animationplayer.play("idle")

func _process_attack1(delta):
	pass#global_position = lerp(global_position,Global.player.global_position+350*Vector2.UP,movement_speed/100*delta)
	
func _physics_process_attack1(delta):
	global_position = lerp(global_position,Global.player.global_position+350*Vector2.UP,movement_speed/100*delta)
	
func _process_attack2(delta):
	pass
func _physics_process_attack2(delta):
	global_position = lerp(global_position,rand_location,movement_speed/100*delta)
	
func _process_attack3(delta):
	pass
	
	
	
	
	
	
	
