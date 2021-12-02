extends BulletGenerator

class_name DeflectGenerator

func _ready():
	targets = TARGETS.ENEMY
	z_index = -1

func add_to_generator_array():
	Global.player_generators.append(self)

func add_bullet(bullet):
	bullet.rotation = bullet.rotation + PI
	bullet.velocity = -bullet.velocity
	bullet.current_time = 0
	bullet.generator = self
	bullets.append(bullet)
	return bullet
