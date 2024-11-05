extends State
class_name WallJumpState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("in_air")
	print("Enter " + name + " state")
	player.jump();
	
func update(_delta:float):
	get_parent().change_state(self, "InAirState")

func exit():
	pass
