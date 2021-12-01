extends Boss

var attack_timer : float = 0.0
var attack_cooldown : float = 0.5
var attacking : bool = false
var current_attack : int = 0

onready var animationplayer : AnimationPlayer = $Sprite/AnimationPlayer

func _process(delta):
	$CanvasLayer/Healthbar.material.set_shader_param("health_percentage",health/max_health)
	attack_timer -= delta
	if attacking:
		match current_attack:
			1: _process_attack1(delta)
			2: _process_attack2(delta)
			3: _process_attack3(delta)
	elif attack_timer <= 0:
		attack()

func attack():
	current_attack = randi()%3+1
	attacking = true
	animationplayer.play(str(current_attack)+"napad")
		

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ["1napad","2napad","3napad"]:
		attacking = false
		attack_timer = attack_cooldown
		animationplayer.play("idle")

func _process_attack1(delta):
	pass
	
func _process_attack2(delta):
	pass
	
func _process_attack3(delta):
	pass
	
	
	
	
	
	
	
