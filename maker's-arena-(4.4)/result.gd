extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var player1_node = get_node("../Player1")
	#var player2_node = get_node("../Player2")
	#game.player_won.connect(_update_result)
	#var my_label = get_node("MarginContainer/CenterContainer/VBoxContainer/Result")
	text = str(game.result_text)
	pass # Replace with function body.

#func _update_result(winner):
	#print("There should be a result of " + str(winner))
	#$Result.text = str(winner)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
