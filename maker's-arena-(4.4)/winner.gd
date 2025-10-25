extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$MarginContainer/CenterContainer/VBoxContainer/Result.text = game.result_text
	#var winning_player_announcement = get_node(/root/game)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(InputEvent) -> void:
	if Input.is_action_just_pressed("space"):
		game.change_scene("res://Arena.tscn")
	elif Input.is_action_just_pressed("esc"):
		# yo i don't think this is working rn
		game.change_scene("res://MainMenu.tscn")


#func _on_arena_player_won(winner: Variant) -> void:
	#game.result_text = winner
	#pass # Replace with function body.
