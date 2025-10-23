extends Node

@export var music: AudioStream
var result_text: String = ""
var num_rounds:= 5
var p1_score = 0
var p2_score = 0
var allow_arena_input = false
var allow_p2_input = false
var solo_mode = false
var timer_on = false
var can_have_timer = true
var music_on = true

var PLAYER_1_SPEED = 36200.0
var PLAYER_2_SPEED = 36200.0

signal player_won(winner)
signal change_num_rounds(new_num)

func _ready():
	if music_on:
		if music and not audio.playing:
			audio.play_music(music, -5.0)
	else:
		audio.stop()

func on_change_num_rounds(new_num) -> void:
	num_rounds = new_num
	# 2 do, figure out how i can save the number change after exiting settings
	# good news i think that's done

func _start_timer() -> void:
	if can_have_timer:
		var timer
	
		timer = Timer.new()
		timer.connect("timeout", Callable(self, "_on_timer_timeout"))
		timer.set_wait_time(4)
		timer.one_shot = true
		add_child(timer)
		timer.start()
		timer_on = true
		#get_node("../Arena/CenterContainer/TimerLabel").display = true
		allow_arena_input = false
		allow_p2_input = false
		print("timer started")
		# i can definitely redo this with signals...
	else:
		allow_arena_input = true
		allow_p2_input = true
	
func _on_timer_timeout():
	allow_arena_input = true
	allow_p2_input = true
	timer_on = false
	#get_node("/root/Arena/CenterContainer/TimerLabel").display = false
	print("timer_ended!")
