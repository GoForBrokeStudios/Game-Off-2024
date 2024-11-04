extends Area2D

@onready var secret_layer = get_parent().find_child("Secrets")

func _on_body_entered(body):
	secret_layer.visible = !secret_layer.visible
