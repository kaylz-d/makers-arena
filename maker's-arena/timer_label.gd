extends Label

var elapsed_time = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	elapsed_time += (delta) 
	#
	print(str(int(elapsed_time)))
	
	if game.timer_on:
		show()
	else:
		hide()
		
	text = str(int(4 - elapsed_time))
	
	pass
