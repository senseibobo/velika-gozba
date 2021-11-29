extends BulletGenerator


onready var krastavac = get_parent()
onready var sprite = krastavac.get_node("Sprite")
onready var puskapos = sprite.get_node("Puska/PuskaPos")

func shoot():
	if not is_instance_valid(Global.player): return
	global_position = puskapos.global_position
	var bullet = Bullet.new()
	bullet.source = krastavac
	bullet.position = global_position
	var dir = sign(Global.player.global_position.x-krastavac.global_position.x)
	bullet.rotation = Vector2(dir,0).angle()
	bullet.velocity = Vector2(dir*speed,0)
	add_bullet(bullet)
	