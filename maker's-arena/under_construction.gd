extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		game.change_scene("res://MainMenu.tscn")
