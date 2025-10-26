extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.current_scene = "Main Menu"
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# weird, if i move it under input(InputEvent) then everything breaks
func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("space"):
		if game.current_scene == "Main Menu":
			game.change_scene("res://Arena.tscn")
			print("menu's fault")
	if Input.is_action_just_pressed("s"):
		game.change_scene("res://Settings.tscn")
	if Input.is_action_just_pressed("t"):
		game.change_scene("res://Tutorial.tscn")
