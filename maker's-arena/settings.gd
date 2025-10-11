extends Node

var current_num_rounds = game.num_rounds
signal change_num_rounds(new_num)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("MainMenu")
		# going homem
	elif Input.is_action_pressed("w"):
		emit_signal(current_num_rounds + 1)
	elif Input.is_action_pressed("s"):
		if current_num_rounds > 1:
				emit_signal(current_num_rounds - 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
