extends Node

var current_level : int = 0
var level_path : String = "res://Scenes/Levels/"

var stopwatch

func _ready():
	SilentWolf.configure({
		"api_key": "DRN04tPFgJ2QYzYR385MXASLgOWPH6f8Qnwd9ID5",
		"game_id": "EchoesfromBelow",
		"log_level": 1
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn"
 	})

	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	

func level_complete():
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	stopwatch.stop()
	
	CustsceneManager.level_complete_animation()

func next_level():
	current_level += 1
	
	var full_path = level_path + "level_" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	
	CustsceneManager.level_start_animation()

func submit_player_score(player_name : String):
	var score = stopwatch.time
	
	# leaderboard variable is used to save to the correct level's leaderboard
	var leaderboard = "level" + str(current_level)
	if current_level == 1: leaderboard = "main"
	
	SilentWolf.Scores.save_score(player_name, score, leaderboard)

func retrieve_high_score() -> String:
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	var highscore = str(sw_result.scores[sw_result.scores.size() - 1]["score"])

	return highscore

func retrieve_high_score_player() -> String:
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	var player_name = str(sw_result.scores[sw_result.scores.size() - 1]["player_name"])
	return player_name
