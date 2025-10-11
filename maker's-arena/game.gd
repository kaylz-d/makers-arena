extends Node

var result_text: String = ""
var num_rounds:= 5
var p1_score = 0
var p2_score = 0

signal player_won(winner)
signal change_num_rounds(new_num)

func on_change_num_rounds(new_num) -> void:
	num_rounds = new_num
	# 2 do, figure out how i can save the number change after exiting settings
