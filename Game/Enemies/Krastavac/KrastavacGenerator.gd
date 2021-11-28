extends BulletGenerator


onready var krastavac = $"../../.."
onready var sprite = $"../.."

func shoot():
	var bullet = Bullet.new()
	bullet.position = global_position
	bullet.velocity = Vector2(-sign(sprite.scale.x)*speed,0)
	bullet.source = krastavac
	bullet.life_time = life_time
	bullet.rotation = Vector2(-sign(sprite.scale.x),0).angle()
	add_bullet(bullet)
	
