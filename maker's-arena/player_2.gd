class_name Player2 extends CharacterBody2D

#@onready var my_node2d = $Node2D
#@onready var my_collision = $CollisionPolygon2D

@onready var spawner = get_parent().get_node("Spawn")

#var SPEED = 36200.0
var BOT_SPEED = 32000.0
#var PUSH_FORCE := 400.0
var MIN_PUSH_FORCE := 200.0
#var ROTATION_SPEED := 5.2
var bounce_strength := 0.6
var bounce_timer := 0.0
var good_to_bounce
var p2_starting_rotation := 0.0

#const ACCELERATION = 1200.0
#const FRICTION = 800.0

const p2_xi := 930.0
const p2_yi := 400.0

var just_reset = false

func _ready() -> void:	
	
	game.current_scene_imo = "Arena"

	if has_node("Node2D"):
		var my_node2d = get_node("Node2D")
		var my_collision = get_node("CollisionPolygon2D")
	
		if game.solo_mode:
			rotation = 0.0 # tricky.
			my_node2d.rotation = -90.0
			my_collision.rotation = -90.0
		else:
			rotation = -90.0
			my_node2d.rotation = 0.0
			my_collision.rotation = 0.0
	
	#var player2 = find_child("Node2D")
	#print(player2)
	# only exists after arena is open

func _good_to_bounce() -> void:
	if is_on_ceiling() or is_on_wall() or is_on_floor():
		good_to_bounce = true
	else:
		good_to_bounce = false

func _physics_process(delta: float) -> void:
	
	#print("Player 2 Speed: " + str(game.PLAYER_2_SPEED))
	
	#print(typeof(game.current_scene), " is ", game.current_scene)
	if game.current_scene_imo == "Arena":
		var input_velocity := Vector2.ZERO
		
		#if _good_to_bounce():
			#input_velocity = Vector2.UP.rotated(rotation) * -(SPEED * 0.6) * delta
			#print("we can bounce rn")
		#else:
			#print("but not now")
			#input_velocity = Vector2.ZERO
		if game.solo_mode:
					
					print("solo mode is true from p2.gd")
					MIN_PUSH_FORCE = 100.0
					game.PLAYER_2_PUSH_FORCE = 180.0
					game.PLAYER_2_SPEED = BOT_SPEED
					
					# SOLO MODE IS BROKEN HERE AGAIN BAIIIIII
					# the % nodes aren't working (T_T) i get the error that they're null
					# idk whyyyy
					
					#var look_at_offset = Vector2(0, -20)
					var look_at_offset = Vector2(0, 0)
					var distance_from_out = (global_position - %Out_CollisionPolygon2D.position).length()
					var direction_from_out = (global_position - %Out_CollisionPolygon2D.position).normalized()
					
					var distance_from_p1 = (global_position - %Player1.position).length()
					var direction_from_p1_cl = (global_position - %Player1.position).length() # normalized
					var dangerous = false
					
					const safe_from_p1 = 100.0
					
					game.allow_p2_input = false
					if game.can_have_timer:
						if game.timer_on:
							#rotation = deg_to_rad(p2_starting_rotation)
							print("rotation reset")
							input_velocity = Vector2.ZERO
						else:
							
							if distance_from_out <= 10.0 and distance_from_p1 <= safe_from_p1:
								look_at(%OutArea2D.position)
								rotation += deg_to_rad(180) * 2
								input_velocity = direction_from_out * game.PLAYER_2_SPEED
								dangerous = true
							elif distance_from_out <= 15.0 and distance_from_p1 <= safe_from_p1:
								look_at(%OutArea2D.position)
								rotation += deg_to_rad(180) * 2
								dangerous = true
								input_velocity = direction_from_out * BOT_SPEED
							else:
								dangerous = false
								look_at(%Player1.position + look_at_offset)
								#rotation += 90
								# will walk right into out area tho :(
								rotation -= deg_to_rad(270) * 2
								print("rotation reset 180")
								input_velocity = -transform.x * BOT_SPEED
					elif !game.can_have_timer:
						if distance_from_out <= 10.0 and distance_from_p1 <= safe_from_p1:
							#input_velocity = direction_from_out.normalized() * SPEED
							look_at(%OutArea2D.position)
							rotation += deg_to_rad(180) * 2
							dangerous = true
							input_velocity = direction_from_out * game.PLAYER_2_SPEED
						elif distance_from_out <= 15.0:
							#input_velocity = direction_from_out.normalized() * BOT_SPEED
							look_at(%OutArea2D.position)
							rotation += deg_to_rad(180) * 2
							dangerous = true
							input_velocity = direction_from_out * BOT_SPEED
						else:
							look_at(%Player1.position + look_at_offset)
							#rotation += 90
							rotation -= deg_to_rad(270)* 2
							input_velocity = -transform.x * BOT_SPEED
		else:
			MIN_PUSH_FORCE = 200.0
			game.PLAYER_2_PUSH_FORCE = 300.0
			#game.PLAYER_2_SPEED = 36200.0
						
		if game.can_have_timer:
			if game.allow_p2_input:
				if Input.is_action_pressed("left_p2"):
					rotation -= game.PLAYER_2_ROT_SPEED * delta
				if Input.is_action_pressed("right_p2"):
					rotation += game.PLAYER_2_ROT_SPEED * delta
			
				if Input.is_action_pressed("up_p2"):
					input_velocity = Vector2.UP.rotated(rotation) * game.PLAYER_2_SPEED # * delta
				elif Input.is_action_pressed("down_p2"):
					input_velocity = Vector2.UP.rotated(rotation) * -game.PLAYER_2_SPEED # * delta
				else:
					input_velocity = Vector2.ZERO
	# there's defo some redundancies, maybe rewrite later

		else:
			game.allow_p2_input = true
			game.allow_arena_input = true
			if Input.is_action_pressed("left_p2"):
				rotation -= game.PLAYER_2_ROT_SPEED * delta
			if Input.is_action_pressed("right_p2"):
				rotation += game.PLAYER_2_ROT_SPEED * delta
			
			if Input.is_action_pressed("up_p2"):
				input_velocity = Vector2.UP.rotated(rotation) * game.PLAYER_2_SPEED # * delta
			elif Input.is_action_pressed("down_p2"):
				input_velocity = Vector2.UP.rotated(rotation) * -(game.PLAYER_2_SPEED) # * delta
		
		velocity = input_velocity * delta
		
		move_and_slide()
		good_to_bounce = false
		
		var collision_count = get_slide_collision_count()
		
		if collision_count > 0:
			#print("Collision count: ", collision_count)
			for i in range(collision_count):
				var c = get_slide_collision(i)
				#print(c.get_collider)
				#print(other)
				
				if typeof(c) == TYPE_OBJECT and c is KinematicCollision2D:
					var other := c.get_collider()
					var normal := c.get_normal()
					if other is CharacterBody2D:
						var pushforce = (game.PLAYER_2_PUSH_FORCE * velocity.length() / (game.PLAYER_2_SPEED)) + MIN_PUSH_FORCE
						other.global_position += -normal * pushforce * delta
						#print("We did this instead") #in fact, we did do this (T_T)
						#took so long to debug
					elif other is RigidBody2D:
						var bounce_normal = normal.normalized()
						velocity = velocity.bounce(bounce_normal) * bounce_strength
						print("bounce da rigid")
						good_to_bounce = true
						move_and_slide()
						#bounce_timer = 0.15
				
		# currently looking for a way to turn timer on and off
				
				#if c:
					#if c.get_collider() is CharacterBody2D:
						#var push_force = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE
						#c.get_collider().apply_central_impulse(-c.normal * push_force)

signal p1_score_changed(new_score)
var score := 0

# i = initial bro

# i should set a timer before the reset...
func _p2_reset_position() -> void:	
	just_reset = true
	position = Vector2(p2_xi, p2_yi)
	print(position)
	if game.solo_mode:
		rotation = 0.0 # tricky.
		get_node("Node2D").rotation = -90.0
		get_node("CollisionPolygon2D").rotation = -90.0
	else:
		rotation = -90.0
		get_node("Node2D").rotation = 0.0
		get_node("CollisionPolygon2D").rotation = 0.0
	velocity = Vector2(0.0, 0.0)
	
	%Player1.position = Vector2(220.0, 400.0)
	%Player1.rotation = 90
	%Player1.velocity = Vector2(0.0,0.0)
	
	

func _on_out_area_2d_body_entered(body: Node2D) -> void:
	if !game.timer_on:
		if body is CharacterBody2D:
			if body.name == ("Player2"):
				#game.player_won.emit("PLAYER 1 WINS")
				#print("emitted signal that p1 wins")
				
				score += 1
				emit_signal("p1_score_changed", score)
				_p2_reset_position()
				if game.can_have_timer:
					game._start_timer()
				#print("P2 is OUT")
				if score == game.num_rounds:
					game.result_text = "PLAYER 1 WINS"
					get_tree().change_scene_to_file("res://Winner.tscn")
				
				#var label = get_node("Winner/MarginContainer/CenterContainer/VBoxContainer/Result")
				#label.text = "Player 1 Wins!"

#func SPD_collected():
	#game.PLAYER_2_SPEED = 52600.0
	#collectible_controller.emit_signal("SPD_collected")

func _on_spawn_body_entered(body: Node2D) -> void:
	var spawner = get_parent().get_node("Spawn")
	
	if body is CharacterBody2D:
		if body.name == ("Player2"):
			game.PLAYER_2_SPEED = 62600.0
			spawner.remove_child(get_node("SPD"))
			("this worked")
	elif body is Area2D:
		if body.name == ("Spawn"):
			game.PLAYER_2_SPEED = 62600.0
			remove_child(%Spawn)
			("Spawn worked")
		elif body.name == ("SPD"):
			game.PLAYER_2_SPEED = 62600.0
			remove_child(%Spawn)
			("SPD worked")
	pass # Replace with function body.
