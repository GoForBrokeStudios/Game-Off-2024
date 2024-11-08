extends State
class_name WalkState

@export var sprite : AnimatedSprite2D

func enter():
	sprite.stop()
	sprite.play("walk")
	player = get_parent().get_parent()
	print("Enter " + name + " state")
	
	# Makes Jump available and stops Coyote Timer
	player.jump_available = true
	if player.coyote_timer:
		player.coyote_timer.stop()
		
	# Checks if player presses jump right before landing
	if player.jump_buffer:
		player.jump()
		player.jump_buffer = false

func update(_delta:float):
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	player.check_if_should_flip(direction)
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	
	if(!direction):
		get_parent().change_state(self, "IdleState")
	
	if Input.is_action_just_pressed("Jump"):
		get_parent().change_state(self, "JumpState")
		
	if not player.is_on_floor():
		get_parent().change_state(self, "InAirState")

func exit():
	pass
