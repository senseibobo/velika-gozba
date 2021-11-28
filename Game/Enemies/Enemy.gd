extends Character


func _ready():
	Global.enemies.append(self)

func death(source):
	.death(source)
	Global.enemies.erase(self)
