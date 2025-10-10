extends Node

var p1_score := 0
var p2_score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var player1 = $PLayer1
	#var player2 = $Player2
	
	#player1.connect("p2_score_changed", Callable(self, "_on_p2_score_changed"))
	#player2.connect("p1_score_changed", Callable(self, "_on_p1_score_changed"))
	pass # Replace with function body.
	
func _on_p2_score_changed(score):
	p1_score = score
	
func _on_p1_score_changed(score):
	p2_score = score

#wait why do i have two of these


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
			get_tree().change_scene_to_file("Tutorial.tscn")
			print("this runs")
	#if str(get_node(".")) == "Arena":
		#if Input.is_action_just_pressed("esc"):
			#get_tree().change_scene_to_file("../Tutorial")
			#print("this runs")


func _on_player_1_p_2_score_changed(new_score: Variant) -> void:
	p2_score = new_score
	print(new_score)
	_update_score()
	pass # Replace with function body.


func _on_player_2_p_1_score_changed(new_score: Variant) -> void:
	p1_score = new_score
	print(str(new_score) + " for P1")
	_update_score()
	pass # Replace with function body.

signal player_won(winner)
func _update_score() -> void:
	get_node("UI/MarginContainer/CenterContainer/Score").text = str(p1_score) + " - " + str(p2_score)
	
	#if (p1_score) == 10:
		##emit_signal("player_won", "PLAYER 1 WINS")
		#get_tree().change_scene_to_file("Winner.tscn")
	#elif (p2_score) == 10:
		##emit_signal("player_won", "PLAYER 2 WINS")
		#get_tree().change_scene_to_file("Winner.tscn")
	pass
	
