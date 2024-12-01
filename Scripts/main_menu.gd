extends Node2D

@export var play_button : Button

@onready var control_panel = $CanvasLayer/Controls

func _on_play_button_down() -> void:
	GameManager.next_level()


func _on_close_controls_pressed():
	control_panel.visible = false

func _on_controls_pressed():
	control_panel.visible = true
