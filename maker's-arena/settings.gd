extends Node

####################### IDEA: SWITCH "W" and "S" around so it's like more intuitive? lol

var current_num_rounds = game.num_rounds
var current_selection = 0

@onready var selection_arrow = get_node("Selection_arrow")

# 0 = change num rounds
# 1 = change solo mode
# 2 = timer
# 3 = music

#1 NUM ROUNDS
@onready var thelabel = get_node("MarginContainer/MarginContainer/ALL_SETTINGS/Number_Rounds/Label_Num_Rounds")

#2 SOLO MODE
@onready var onLabel = get_node("MarginContainer/MarginContainer/ALL_SETTINGS/Solo_Mode/HBoxContainer/VBoxContainer/Increase")
@onready var offLabel = get_node("MarginContainer/MarginContainer/ALL_SETTINGS/Solo_Mode/HBoxContainer/VBoxContainer2/Decrease")

#3 TIMER
@onready var specific_offLabel = get_node("MarginContainer/MarginContainer/ALL_SETTINGS/Timer/HBoxContainer/VBoxContainer/Increase")
@onready var specific_onLabel = get_node("MarginContainer/MarginContainer/ALL_SETTINGS/Timer/HBoxContainer/VBoxContainer2/Decrease")

#4 MUSIC
@onready var musicOFF = get_node("MarginContainer/MarginContainer/ALL_SETTINGS/Volume/HBoxContainer/VBoxContainer/OFF")
@onready var musicON = get_node("MarginContainer/MarginContainer/ALL_SETTINGS/Volume/HBoxContainer/VBoxContainer2/ON")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_num_rounds = game.num_rounds
	_update_num_rounds_label()
	
	# ready solo
	if game.solo_mode:
		offLabel.add_theme_color_override("font_color", Color("#20CBD7"))
		onLabel.add_theme_color_override("font_color", Color("#540237"))
	else:
		offLabel.add_theme_color_override("font_color", Color("#064a4f"))
		onLabel.add_theme_color_override("font_color", Color("#f979be"))
	
	# ready timer
	if game.can_have_timer:
		if game.timer_on:
			specific_offLabel.add_theme_color_override("font_color", Color("#540237"))
			specific_onLabel.add_theme_color_override("font_color", Color("#20CBD7"))
	else:
		specific_offLabel.add_theme_color_override("font_color", Color("#f979be"))
		specific_onLabel.add_theme_color_override("font_color", Color("#064a4f"))
	
	# ready music
	if game.music_on:
		musicOFF.add_theme_color_override("font_color", Color("#540237"))
		musicON.add_theme_color_override("font_color", Color("#20CBD7"))
	else:
		musicOFF.add_theme_color_override("font_color", Color("#f979be"))
		musicON.add_theme_color_override("font_color", Color("#064a4f"))
	
	pass # Replace with function body.
	
func _update_num_rounds_label() -> void:
	thelabel.text = "Number of Points to Win: " + str(current_num_rounds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
		# going home
	
	if Input.is_action_just_pressed("down_p2"):
		if current_selection <= 2:
			current_selection += 1
	if Input.is_action_just_pressed("up_p2"):
		if current_selection >= 1:
			current_selection -=1
		
	if current_selection == 0:
		selection_arrow.position = Vector2(80.0, 214.0)
		if Input.is_action_just_pressed("s"):
			current_num_rounds += 1
			print("adding a round")
			game.num_rounds = current_num_rounds
			_update_num_rounds_label()
		if Input.is_action_just_pressed("w"):
			if current_num_rounds > 1:
				current_num_rounds -= 1
				game.num_rounds = current_num_rounds
				_update_num_rounds_label()
	elif current_selection == 1: # SOLO MODE
		selection_arrow.position = Vector2(80.0, 284.0)
		if Input.is_action_just_pressed("s"):
			game.solo_mode = false
			offLabel.add_theme_color_override("font_color", Color("#064a4f"))
			onLabel.add_theme_color_override("font_color", Color("#f979be"))
		if Input.is_action_just_pressed("w"):
			game.solo_mode = true
			print("solo mode is true")
			offLabel.add_theme_color_override("font_color", Color("#20CBD7"))
			onLabel.add_theme_color_override("font_color", Color("#540237"))
			
	elif current_selection == 2: #TIMER
		selection_arrow.position = Vector2(80.0, 354.0)
		
		if Input.is_action_just_pressed("w"):
			#game.timer_override = true
			game.can_have_timer = true
			game.timer_on = true
			specific_offLabel.add_theme_color_override("font_color", Color("#540237"))
			specific_onLabel.add_theme_color_override("font_color", Color("#20CBD7"))
			print("made it")
		if Input.is_action_just_pressed("s"):
			#game.timer_override = false
			specific_offLabel.add_theme_color_override("font_color", Color("#f979be"))
			specific_onLabel.add_theme_color_override("font_color", Color("#064a4f"))
			print("here")
			game.can_have_timer = false
			game.timer_on = false
	elif current_selection == 3:
		selection_arrow.position = Vector2(80.0, 424.0)
		if Input.is_action_just_pressed("w"):
			game.music_on = true
			musicOFF.add_theme_color_override("font_color", Color("#540237"))
			musicON.add_theme_color_override("font_color", Color("#20CBD7"))
			print("music on")
		if Input.is_action_just_pressed("s"):
			game.music_on = false
			musicOFF.add_theme_color_override("font_color", Color("#f979be"))
			musicON.add_theme_color_override("font_color", Color("#064a4f"))
			print("music off")
	
	pass
