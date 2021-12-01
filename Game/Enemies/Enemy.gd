extends Character
class_name Enemy


export var death_particles_scene : PackedScene
export var hit_sound : AudioStream
export var death_sound : AudioStream
export var spotted_sound : AudioStream
export var hitbox_radius : float = 5
export var aggro_range = 400
export var deaggro_range = 600
export var score_reward : float = 30.0
export var score_multiplier_reward : float = 0.1

onready var sprite = get_node("Sprite")
onready var start_pos : Vector2 = global_position

var spotted_player : bool = false
var stagger_duration : float = 0.3
var stagger_timer : float = 0.0



func _ready():
	max_health *= 1+(Global.difficulty-1)/3.0
	health = max_health
	sprite.set_material(preload("res://Materials/HitFlash.material").duplicate())
	Global.enemies.append(self)

func _process(delta):
	stagger_timer -= delta
	if is_instance_valid(Global.player):
		var dist = global_position.distance_to(Global.player.global_position)
		if spotted_player and dist > deaggro_range:
			spotted_player = false
		elif is_instance_valid(Global.player) and dist < aggro_range:
			if not spotted_player:
				SFX.play_sound(spotted_sound)
			spotted_player = true

func hit(damage,source):
	hit_flash()
	stagger_timer = stagger_duration
	.hit(damage,source)

func hit_flash():
	var tween = Tween.new()
	add_child(tween)
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.interpolate_property(sprite.get_material(),"shader_param/flash_amount",1.0,0.0,0.15)
	tween.start()
	
func death(source):
	.death(source)
	SFX.play_sound(death_sound)
	if death_particles_scene != null:
		var particles = death_particles_scene.instance()
		get_parent().add_child(particles)
		particles.emitting = true
		particles.global_position = global_position
	LevelManager.add_score(score_reward)
	LevelManager.add_score_multiplier(score_multiplier_reward)
	Global.player.health = min(Global.player.health + 10+(2-Global.difficulty)*5,Global.player.max_health)
	queue_free()
	Global.enemies.erase(self)
