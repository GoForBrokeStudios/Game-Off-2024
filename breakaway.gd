extends Area2D

@export var secret_layer : TileMapLayer

func _on_body_entered(body):
	secret_layer.visible = !secret_layer.visible

func _on_body_exited(body):
	secret_layer.visible = !secret_layer.visible
