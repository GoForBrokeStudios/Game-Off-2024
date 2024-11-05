extends State
class_name InAirState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("in_air")
	print("Enter " + name + " state")
	
	# Starts Coyote Timer if Jump is available
	if player.jump_available == true:
			if player.coyote_timer.is_stopped():
				player.coyote_timer.start(player.coyote_time)

func update(_delta:float):
	if player.is_on_floor():
		get_parent().change_state(self, "IdleState")
	
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	
	if player.is_on_wall() and direction:
		player.last_direction = direction
		get_parent().change_state(self, "WallSlideState")
		
	if Input.is_action_just_pressed("Jump"):
		# The player will only jump if the jump_available is true (Jump Buffer)
		get_parent().change_state(self, "JumpState")
		
	if Input.is_action_just_pressed("Dive") && player.velocity.x != 0:
		player.last_direction = direction
		get_parent().change_state(self, "DiveState")
	
func exit():
	pass
