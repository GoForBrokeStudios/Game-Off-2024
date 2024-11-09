extends Node2D

@export var play_button : Button

func _on_play_button_down() -> void:
	GameManager.next_level()
