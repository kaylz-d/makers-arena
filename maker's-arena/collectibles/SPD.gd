extends Node2D

#func _on_area_2d_body_entered(body):
	#if body is Player1:
		#player_1.SPD_collected()
		#self.queue_free()
	#elif body is Player2:
		#player_2.SPD_collected()
		#self.queue_free()
