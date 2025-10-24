extends Node2D

func _on_area_2d_body_entered(body):
	if body is Player1:
		arena.SPD_collected("Player1")
		self.queue_free()
	elif body is Player2:
		arena.SPD_collected("Player2")
		self.queue_free()
