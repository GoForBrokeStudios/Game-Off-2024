extends State
class_name IdleState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("idle")
	print("Enter " + name + " state")
	
	player.set_velocity(Vector2.ZERO)
	
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
	
	if(direction):
		get_parent().change_state(self, "WalkState")
	
	if Input.is_action_just_pressed("Jump"):
		get_parent().change_state(self, "JumpState")
		
	if not player.is_on_floor() && !player.jump_available:
		get_parent().change_state(self, "InAirState")

func exit():
	pass
