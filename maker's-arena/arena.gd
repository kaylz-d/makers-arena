extends Node
# maybe in the future, try making the players as their own scenes
# might need to use signals for interactions with the arena but it would be ok

#@onready var Player2 = get_node("Player2")
#@onready var Player2_Node2D = get_node("Player2/Node2D")
#@onready var Player2_CollisionPolygon2D = get_node("Player2/CollisionPolygon2D")

var p1_score := 0
var p2_score := 0
#@onready var Player2 := %Player2
#@onready var player_2 = preload("res://player_2.tscn")

var SPD_scene = preload("res://collectibles/SPD.tscn")
var FORCE_scene = preload("res://collectibles/FORCE.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("this is readying tOOO MUCH")
	game.current_scene_imo = "Arena"
	
	#print("Children of ", self.name, ":", get_children())
	#print("Player 2 exists?", has_node("Player2"))
	# this works only after switching to the arena screen
	
	#print("Does Player 2 exist here?", has_node("/root/Player2"))
	#print("Does Player 2 exist here?", has_node("Players/Player2"))
	#print("Does Player 2 exist here?", has_node("res://player_2.tscn"))
	#print("Does Player 2 exist here?", has_node("player_2"))
	#var Player2 = get_node("Player2")
	#var Player2_Node2D = get_node("Player2/Node2D")
	#var Player2_CollisionPolygon2D = get_node("Player2/CollisionPolygon2D")
	#var player1 = $PLayer1
	#var player2 = $Player2
	
	
	#if game.solo_mode:
		#Player2.rotation = 0.0 # tricky.
		#Player2_Node2D.rotation = -90.0
		#Player2_CollisionPolygon2D.rotation = -90.0
	#else:
		#Player2.rotation = -90.0
		#Player2_Node2D.rotation = 0
		#Player2_CollisionPolygon2D.rotation = 0
		
	
	game._start_timer()
	pass # Replace with function body.
	
func _on_p2_score_changed(score):
	p1_score = score
	
func _on_p1_score_changed(score):
	p2_score = score

#wait why do i have two of these

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# timer isn't working rn
	# idk whyyy but it's saying that the TimerLabel node is a null instance
	
	#var timer_node = get_node("CenterContainer/TimerLabel")
	#var elapsed_time = 0.0
	#elapsed_time += delta
	#if elapsed_time <= 3:
		#get_node("CenterContainer/TimerLabel").text = str(elapsed_time)
	
	if Input.is_action_just_released("esc"):
			# WHYYYYY DOES THIS PRINT TWICE BYE
			print("this runs")
			get_tree().change_scene_to_file("res://MainMenu.tscn")
	#if str(get_node(".")) == "Arena":
		#if Input.is_action_just_pressed("esc"):
			#get_tree().change_scene_to_file("../Tutorial")
			#print("this runs")
	#if Input.is_action_just_pressed("space"):
		#return
	
	pass

#func _input(InputEvent) -> void:
	## what if i moved this under process
	#pass


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

#signal player_won(winner)
func _update_score() -> void:
	get_node("UI/MarginContainer/CenterContainer/Score").text = str(p1_score) + " - " + str(p2_score)
	
	#if (p1_score) == 10:
		##emit_signal("player_won", "PLAYER 1 WINS")
		#get_tree().change_scene_to_file("Winner.tscn")
	#elif (p2_score) == 10:
		##emit_signal("player_won", "PLAYER 2 WINS")
		#get_tree().change_scene_to_file("Winner.tscn")
	pass

func roll_random_orb() -> PackedScene:
	var generate_num := randi_range(0, 2)
	if generate_num == 0:
		print("generated this fr: " + str(generate_num))
		game.last_powerup = "FORCE"
		return FORCE_scene
	else:
		print("ELSE we generated this fr: " + str(generate_num))
		game.last_powerup = "SPD"
		return SPD_scene

func spawn_powerup() -> void:
	print("spawn_powerup() running")
	var spawner = get_node("Spawn")
	
	if spawner.get_child_count() > 0:
		return
	
	var a_random_orb = roll_random_orb().instantiate()
	
	var picked_x = randf_range(100.0, 1000.0)
	var picked_y = randf_range(100.0, 500.0)
	
	if picked_x > 350.0 and picked_x < 760.0:
		if picked_y > 100.0 and picked_y < 300.0 :
			while picked_y > 100.0 and picked_y < 300.0:
				picked_y = randf_range(100.0, 500.0)
	
	var picked_position = Vector2(picked_x, picked_y)
	a_random_orb.position = picked_position
	spawner.add_child(a_random_orb)


func _on_powerup_timer_timeout() -> void:
	spawn_powerup()
	print("shoulda spawned")
	
func SPD_collected(player: String):
	
	#var a_SPD_orb2 = %Spawn.get_child(0)
	#not needed cuz child is already gone
	
	if player == ("Player1"):
		game.PLAYER_1_SPEED += 8000.0
		game.PLAYER_1_ROT_SPEED += 0.5
		#%Spawn.remove_child(a_SPD_orb2)
	elif player == ("Player2"):
		game.PLAYER_2_SPEED += 8000.0
		game.PLAYER_2_ROT_SPEED += 0.5
		#%Spawn.remove_child(a_SPD_orb2)
		
#WORKS!!

func FORCE_collected(player: String):
	# ok i think it's much easier to
	# just make the script a class
	# and then refer to it this way
	if player == ("Player1"):
		game.PLAYER_1_PUSH_FORCE += 300.0
		print("player 1 force: " + str(game.PLAYER_1_PUSH_FORCE))
	elif player == ("Player2"):
		game.PLAYER_2_PUSH_FORCE += 300.0
		print("player 2 force: " + str(game.PLAYER_2_PUSH_FORCE))
