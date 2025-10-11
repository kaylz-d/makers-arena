extends Node

var current_num_rounds = game.num_rounds
#signal change_num_rounds(new_num)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_num_rounds = game.num_rounds
	_update_num_rounds_label()
	pass # Replace with function body.
	
func _update_num_rounds_label() -> void:
	var thelabel = get_node("MarginContainer/Number_Rounds/Label_Num_Rounds")
	thelabel.text = "Number of Points to Win: " + str(current_num_rounds)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
		# going homem
	if Input.is_action_just_pressed("w"):
		current_num_rounds += 1
		print("adding a round")
		game.num_rounds = current_num_rounds
		_update_num_rounds_label()
	if Input.is_action_just_pressed("s"):
		if current_num_rounds > 1:
			current_num_rounds -= 1
			game.num_rounds = current_num_rounds
			_update_num_rounds_label()
	pass
