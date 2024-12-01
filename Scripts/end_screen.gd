extends Node2D

@onready var total_time = $"CanvasLayer/TitleScreen/Your Time/Timer"

@onready var nickname_input = $"CanvasLayer/TitleScreen/Leaderboard User/LineEdit"
@onready var system_input = $CanvasLayer/TitleScreen/system_input

func _ready():
	total_time.text = GameManager.time_to_string(GameManager.current_total_time)
	
	GameManager.current_level = 0

func _on_button_pressed():
	if nickname_input.text == "":
		system_input.text = "Please enter a nickname."
		return
	
	GameManager.submit_player_score(nickname_input.text)
	system_input.text = "Score submitted to leaderboard."
	
func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/examples/CustomLeaderboards/ReverseLeaderboard.tscn")

func _on_play_pressed():
	GameManager.next_level()
