extends State
class_name DiveState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()
	
func enter():
	sprite.play("dive")
	print("Enter " + name + " state")
	
	var current_x_velocity = player.velocity.x
	player.check_if_should_flip(current_x_velocity)
	player.velocity.x = player.DIVE_VELOCITY * (abs(current_x_velocity) / current_x_velocity)

func update(delta:float):
	if player.is_on_floor():
		if Input.is_action_pressed("MoveLeft") or Input.is_action_pressed("MoveRight"):
			get_parent().change_state(self, "RollState")
		else:
			get_parent().change_state(self, "IdleState")

func exit():
	pass
