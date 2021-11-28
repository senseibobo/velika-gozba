extends Character
class_name Enemy

export var death_particles_scene : PackedScene

onready var sprite : Sprite = get_node("Sprite")

func _ready():
	sprite.set_material(preload("res://Materials/HitFlash.material"))
	Global.enemies.append(self)

func hit(damage,source):
	hit_flash()
	.hit(damage,source)

func hit_flash():
	print("As")
	var tween = Tween.new()
	add_child(tween)
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.interpolate_property(sprite.get_material(),"shader_param/flash_amount",1.0,0.0,0.15)
	tween.start()

func death(source):
	.death(source)
	if death_particles_scene != null:
		var particles = death_particles_scene.instance()
		get_parent().add_child(particles)
		particles.emitting = true
		particles.global_position = global_position
	queue_free()
	Global.enemies.erase(self)
