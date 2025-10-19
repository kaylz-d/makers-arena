extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if game.solo_mode:
		if game.timer_on:
			text = "(Currently in SOLO mode + Timer ON)"
		else:
			text = "(Currently in SOLO mode + Timer OFF)"
	elif !game.solo_mode:
		if game.timer_on:
			text = "(Currently in MULTIPLAYER mode + Timer ON)"
		else:
			text = "(Currently in MULTIPLAYER mode + Timer OFF)"
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
