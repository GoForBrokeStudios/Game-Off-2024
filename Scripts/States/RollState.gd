extends State
class_name RollState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("roll")
	print("Enter " + name + " state")
	
	# Makes Jump available and stops Coyote Timer
	player.jump_available = true
	if player.coyote_timer:
		player.coyote_timer.stop()
		
	# Checks if player presses jump right before landing
	if player.jump_buffer:
		player.jump()
		player.jump_buffer = false
	
func update(delta:float):
	var last_direction = player.last_direction
	
	if (last_direction > 0 && player.velocity.x > 0) or (last_direction < 0 && player.velocity.x < 0):
		player.velocity.x += -last_direction * 200.0 * delta
	else:
		get_parent().change_state(self, "IdleState")
		
	if Input.is_action_just_pressed("Jump"):
		player.jump()
		get_parent().change_state(self, "DiveState")
		
	if Input.is_action_just_pressed("MoveRight"):
		if last_direction > 0:
			player.velocity.x += player.ROLL_VELOCITY
		else:
			get_parent().change_state(self, "WalkState")
	elif Input.is_action_just_pressed("MoveLeft"):
		if last_direction < 0:
			player.velocity.x -= player.ROLL_VELOCITY
		else:
			get_parent().change_state(self, "WalkState")

func exit():
	pass
