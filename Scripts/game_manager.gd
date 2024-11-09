extends Node

var current_level : int = 0
var level_path : String = "res://Scenes/Levels/"

var stopwatch

func _ready():
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	

func next_level():
	current_level += 1
	
	if stopwatch:
		stopwatch = get_tree().get_first_node_in_group("stopwatch")
		stopwatch.stop()
	
	TransitionScenes.transition()
	await TransitionScenes.on_transition_finished
	
	var full_path = level_path + "level_" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(full_path)
