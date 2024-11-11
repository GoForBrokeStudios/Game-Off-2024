extends State
class_name JumpState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("in_air")
	print("Enter " + name + " state")
	
	if not player.jump_available:
		player.jump_buffer = true
		get_tree().create_timer(player.jump_buffer_time).timeout.connect(player.on_jump_buffer_timeout)
		return
	
	player.jump_sound.play()
	player.velocity.y = player.jump_velocity
	player.jump_available = false

func update(_delta:float):
	get_parent().change_state(self, "InAirState")

func exit():
	pass
