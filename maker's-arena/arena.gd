extends Node

#@onready var player1 = Player1
#@onready var player2 = Player2

#signal player_won(winner_text: String)
#var player1_score: int = 0
#var player2_score: int = 0
#signal p1_score_changed(_p1_update_score)
#
#func _p1_update_score():
	#$Score.text = str(player1_score) + " - " + str(player2_score)
#
#func _p2_update_score():
	#$Score.text = str(player1_score) + " - " + str(player2_score)
	
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
	pass # Replace with function body.


func _on_player_2_p_1_score_changed(new_score: Variant) -> void:
	p1_score = new_score
	pass # Replace with function body.
