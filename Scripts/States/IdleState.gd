extends State
class_name IdleState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("idle")
	print("Enter " + name + " state")
	
	player.set_velocity(Vector2.ZERO)

func update(_delta:float):
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if(direction):
		get_parent().change_state(self, "WalkState")
	
	if Input.is_action_just_pressed("Jump"):
		get_parent().change_state(self, "JumpState")
		
	if not player.is_on_floor():
		get_parent().change_state(self, "InAirState")

func exit():
	pass
