extends State
class_name PauseState

@export var sprite : AnimatedSprite2D

func _ready():
	player = get_parent().get_parent()

func enter():
	sprite.play("idle")
	print("Enter " + name + " state")
	
	player.velocity = Vector2.ZERO

func update(_delta):
	pass

func exit():
	pass
