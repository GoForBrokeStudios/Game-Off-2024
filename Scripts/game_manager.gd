extends Node

var current_level : int = 1
var level_path : String = "res://Scenes/Levels/"

func next_level():
	current_level += 1
	var full_path = level_path + "level_" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(full_path)
