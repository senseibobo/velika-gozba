extends Character

export var object_path : NodePath 
onready var object : Node2D = get_node(object_path)
onready var animationplayer : AnimationPlayer = object.get_node("AnimationPlayer")
onready var animationtree : AnimationNodeStateMachinePlayback = object.get_node("AnimationTree").get("parameters/playback")

func _ready():
	Global.player = self

func _process(delta):
	_handle_movement()
	_handle_animations()
	

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
		$Object/Node2D.rotation_degrees = 0
		animationtree.travel("idle")
