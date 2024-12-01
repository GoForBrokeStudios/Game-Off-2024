extends State
class_name WallSlideState

@export var sprite : AnimatedSprite2D
@export var wall_jump_area : Area2D

func _ready():
	player = get_parent().get_parent()

func enter():
	print("Enter " + name + " state")
	
	player.fall_gravity = player.fall_gravity / 2.0
	
func update(_delta:float):
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if !player.can_wall_jump:
		get_parent().change_state(self, "InAirState")
	elif Input.is_action_just_pressed("Jump"):
		get_parent().change_state(self, "WallJumpState")
	elif direction != player.last_direction && direction != 0:
		get_parent().change_state(self, "InAirState")
	elif player.is_on_floor():
		get_parent().change_state(self, "IdleState")

func exit():
	player.fall_gravity = player.fall_gravity * 2.0
