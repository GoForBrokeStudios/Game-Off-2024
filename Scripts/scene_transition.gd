extends CanvasLayer

signal on_transition_finished

var color_rect : ColorRect
var anim_player : AnimationPlayer

@export var cutscene_manager : AnimationPlayer

func _ready():
	color_rect = $ColorRect
	anim_player = $AnimationPlayer
	
	color_rect.visible = false
	anim_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		anim_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
		cutscene_manager.play("start")

func transition():
	color_rect.visible = true
	anim_player.play("fade_to_black")
