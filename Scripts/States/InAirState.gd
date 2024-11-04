extends State
class_name InAirState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("in_air")
	print("Enter " + name + " state")

func update(_delta:float):
	if player.is_on_floor():
		get_parent().change_state(self, "IdleState")
	
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		
	if Input.is_action_just_pressed("Dive") && player.velocity.x != 0:
		player.last_direction = direction
		get_parent().change_state(self, "DiveState")
	
func exit():
	pass
