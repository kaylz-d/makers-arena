extends AudioStreamPlayer

var current_stream: AudioStream = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _play_music(music_stream: AudioStream, volume_db: float = 0.0):
	
	if current_stream == music_stream and playing:
		return
	stop()
	
	stream = music_stream
	self.volume_db = volume_db
	current_stream == music_stream
	play()
