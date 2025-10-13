extends Label

var elapsed_time = 0.0

#idk why my timer is broken sometimes


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if game.timer_on == true:
		text = str(int(4 - elapsed_time))
		show()
	else:
		hide()
	
	if game.timer_on != true:
		elapsed_time = 0.0
	else:
		elapsed_time += (delta) 
	#
		print(str(int(elapsed_time)))
	
	pass
