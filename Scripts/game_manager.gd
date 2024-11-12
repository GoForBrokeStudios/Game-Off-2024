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
	get_tree().get_first_node_in_group("player").get_node("StateMachine").force_change_state("PauseState")
	
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	stopwatch.stop()
	
	CustsceneManager.level_complete_animation()

func next_level():
	if current_level != 0:
		get_tree().get_first_node_in_group("player").get_node("StateMachine").force_change_state("IdleState")
		
	current_level += 1
	
	var full_path = level_path + "level_" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	
	CustsceneManager.level_start_animation()

func submit_player_score(player_name : String):
	var score = stopwatch.time
	
	# leaderboard variable is used to save to the correct level's leaderboard
	var leaderboard = check_current_leaderboard()
	
	SilentWolf.Scores.save_score(player_name, score, leaderboard)

func retrieve_high_score() -> String:
	# Sometimes we just have to make sure we have access to the stopwatch
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	
	var leaderboard = check_current_leaderboard()
	
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0, leaderboard).sw_get_scores_complete
	
	var highscore
	# if there is no highscore, we need to set the label to the player's score
	if sw_result.scores.size() == 0:
		highscore = stopwatch.time
	else:
		highscore = sw_result.scores[sw_result.scores.size() - 1]["score"]
		if highscore > stopwatch.time:
			# player's score is the new highscore
			highscore = stopwatch.time
			CustsceneManager.new_high_score_animation()

	return time_to_string(float(highscore))

func retrieve_high_score_player() -> String:
	var leaderboard = check_current_leaderboard()
	
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0, leaderboard).sw_get_scores_complete
	var player_name = str(sw_result.scores[sw_result.scores.size() - 1]["player_name"])
	return player_name

func time_to_string(time:float) -> String:
	# Turns the time var into a string for UI display
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60.0
	var format_string = "%02d:%02d:%03d"
	var actual_string = format_string % [min, sec, msec]
	return actual_string

# Checks what leaderboard we should be using based on the current level
func check_current_leaderboard() -> String:
	var leaderboard = "level" + str(current_level)
	if current_level == 1: leaderboard = "main"
	return leaderboard
