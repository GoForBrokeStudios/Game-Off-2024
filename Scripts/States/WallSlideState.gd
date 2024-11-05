extends State
class_name WallSlideState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	print("Enter " + name + " state")
	
func update(_delta:float):
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if direction == player.last_direction:
		if Input.is_action_just_pressed("Jump"):
			get_parent().change_state(self, "WallJumpState")
	else:
		get_parent().change_state(self, "InAirState")

func exit():
	pass
