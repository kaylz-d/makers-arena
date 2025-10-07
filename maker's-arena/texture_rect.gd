extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _input(InputEvent) -> void:
	if Input.is_action_just_pressed("a"):
		get_tree().change_scene_to_file("res://Arena.tscn")
