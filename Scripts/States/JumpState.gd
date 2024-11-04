extends State
class_name JumpState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	#sprite.play("Idle")
	print("Enter " + name + " state")
	player.jump()

func update(_delta:float):
	get_parent().change_state(self, "InAirState")
	pass

func exit():
	pass
