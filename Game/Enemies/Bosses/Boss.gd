extends Enemy

class_name Boss

func death(source):
	.death(source)
	LevelManager.finish_level(self)
	
