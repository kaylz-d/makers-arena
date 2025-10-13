extends Node

var result_text: String = ""
var num_rounds:= 5
var p1_score = 0
var p2_score = 0
var allow_arena_input = false
var solo_mode = false
var timer_on = false

signal player_won(winner)
signal change_num_rounds(new_num)

func on_change_num_rounds(new_num) -> void:
	num_rounds = new_num
	# 2 do, figure out how i can save the number change after exiting settings
	# good news i think that's done

func _start_timer() -> void:
	var timer
	timer_on = true
	
	timer = Timer.new()
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.set_wait_time(3)
	add_child(timer)
	timer.start()
	#get_node("../Arena/CenterContainer/TimerLabel").display = true
	allow_arena_input = false
	print("timer started")
	
func _on_timer_timeout():
	allow_arena_input = true
	timer_on = false
	#get_node("/root/Arena/CenterContainer/TimerLabel").display = false
	print("timer_ended!")
