extends CanvasLayer

@onready var anim = $AnimationPlayer

@onready var level_complete_container = $"Level Complete"
@onready var level_start_container = $"Level Start"

@onready var score_label = $"Level Complete/Scores/Player Score/Timer"
@onready var high_score_label = $"Level Complete/Scores/High Score/Timer"
@onready var new_high_score_label = $"Level Complete/Scores/High Score/Timer/NewHighScore"
@onready var username_input = $"Level Complete/Scores/Leaderboard Submission/PlayerNameInput"
#@onready var darkness = $Darkness
var torches

@export var max_darkness = 1
@export var min_darkness = 0.6

var player_name : String

func _ready():
	level_complete_container.visible = false
	level_start_container.visible = false
	
func level_complete_animation():
	level_complete_container.visible = true
	level_start_container.visible = false
	anim.play("level_complete")

func level_start_animation():
	level_complete_container.visible = false
	level_start_container.visible = true
	anim.play("level_start")

func set_score_count():
	var stopwatch = get_tree().get_first_node_in_group("stopwatch")
	score_label.text = stopwatch.time_to_string()
	
	high_score_label.text = await GameManager.retrieve_high_score()

func reset_score_labels():
	score_label.text = "00:00:000"
	high_score_label.text = "00:00:000"
	new_high_score_label.visible = false

func new_high_score_animation():
	anim.play("new_high_score")

#func start_intro():
	#play("start")
	
	#torches = get_tree().get_nodes_in_group("torches")
	
#func toggle_torches():
	#for torch in torches:
		#torch.get_node("PointLight2D").energy = 1.6

#func full_dark():
	#darkness.energy = 1
	
	#for torch in torches:
		#torch.get_node("PointLight2D").energy = 0
	
#func increase_light():
	#var t = create_tween()
	#t.tween_property(darkness, "energy", min_darkness, 1.0)


func _on_next_level_pressed() -> void:
	print("done")
	GameManager.next_level()


func _on_submit_b_pressed() -> void:
	player_name = username_input.text
	GameManager.submit_player_score(player_name)
	#var leaderboard = await Leaderboards.get_scores("echoes-from-below-level-1-unwQ")
	#print(leaderboard[0]["score"])
	
	#await Leaderboards.post_guest_score("echoes-from-below-level-1-unwQ", 300, player_name)
	#get_tree().reload_current_scene()


func _on_line_edit_text_submitted(new_text: String) -> void:
	player_name = username_input.text
