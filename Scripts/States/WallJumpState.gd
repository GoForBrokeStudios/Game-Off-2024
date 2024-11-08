extends State
class_name WallJumpState

@export var sprite : AnimatedSprite2D

@onready var wall_jump_timer = $WallJumpTimer

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("in_air")
	print("Enter " + name + " state")
	
	player.velocity = player.get_wall_normal() * 800.0
	player.velocity.y = player.jump_velocity * 0.8
	wall_jump_timer.start()
	
func update(_delta:float):
	if player.is_on_wall():
		wall_jump_timer.stop()
		get_parent().change_state(self, "WallSlideState")

func exit():
	wall_jump_timer.stop()

func _on_wall_jump_timer_timeout():
	get_parent().change_state(self, "InAirState")
