extends Node

var current_level : int = 1
var level_path : String = "res://Scenes/Levels/"

var stopwatch

func _ready():
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	

func level_complete():
	current_level += 1
	
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	stopwatch.stop()
	
	CustsceneManager.level_complete_animation()

func next_level():
	var full_path = level_path + "level_" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	
	CustsceneManager.level_start_animation()
