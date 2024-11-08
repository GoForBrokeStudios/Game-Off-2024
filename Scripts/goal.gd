extends Area2D

func _on_body_entered(body):
	if body is PlayerController:
		GameManager.next_level()
