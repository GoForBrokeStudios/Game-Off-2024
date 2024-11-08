extends AnimationPlayer

var darkness
var torches

@export var max_darkness = 1
@export var min_darkness = 0.6

func _ready():
	darkness = %Darkness
	torches = get_tree().get_nodes_in_group("torches")

func start_intro():
	play("start")
	
func toggle_torches():
	for torch in torches:
		torch.get_node("PointLight2D").energy = 1.6

func full_dark():
	darkness.energy = 1
	
	for torch in torches:
		torch.get_node("PointLight2D").energy = 0
	
func increase_light():
	var t = create_tween()
	t.tween_property(darkness, "energy", min_darkness, 1.0)
