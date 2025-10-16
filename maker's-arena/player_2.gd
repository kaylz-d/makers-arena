extends CharacterBody2D

const SPEED = 46200.0
const PUSH_FORCE := 300.0
const MIN_PUSH_FORCE := 250.0
const ROTATION_SPEED := 5.2
var bounce_strength := 300
var bounce_timer := 0.0

const ACCELERATION = 1200.0
const FRICTION = 800.0

const p2_xi := 930.0
const p2_yi := 400.0

var just_reset = false

#func _good_to_bounce() -> bool:
	#if is_on_ceiling() or is_on_wall() or is_on_floor():
		#return true
	#else:
		#return false

func _physics_process(delta: float) -> void:
		
	var ROTATION_SPEED := 5.2
	var input_velocity := Vector2.ZERO
	
	#if _good_to_bounce():
		#input_velocity = Vector2.UP.rotated(rotation) * -(SPEED * 0.6) * delta
		#print("we can bounce rn")
	#else:
		#print("but not now")
		#input_velocity = Vector2.ZERO
	
	if bounce_timer <= 0.0:
		if game.allow_p2_input:
			if Input.is_action_pressed("left_p2"):
				rotation -= ROTATION_SPEED * delta
			if Input.is_action_pressed("right_p2"):
				rotation += ROTATION_SPEED * delta
		
			if Input.is_action_pressed("up_p2"):
				input_velocity = Vector2.UP.rotated(rotation) * SPEED * delta
			elif Input.is_action_pressed("down_p2"):
				input_velocity = Vector2.UP.rotated(rotation) * -SPEED * delta
			else:
				input_velocity = Vector2.ZERO
		else:
			if Input.is_action_pressed("left_p2"):
				rotation = 0.0
				input_velocity = Vector2.ZERO
			if Input.is_action_pressed("right_p2"):
				rotation = 0.0
				input_velocity = Vector2.ZERO
			
			if Input.is_action_pressed("up_p2"):
				input_velocity = Vector2.ZERO
			if Input.is_action_pressed("down_p2"):
				input_velocity = Vector2.ZERO
	
	velocity = input_velocity
	move_and_slide()
	
	
	#var collision = move_and_collide(velocity * delta)
	#if collision:
		#var normal = collision.getnormal()

	#from tutorial by Queble using RigidBody2D
	# errors saying getnormal does not exist in KinematicCollision2D
	#for i in get_slide_collision_count():
		#var c = get_slide_collision(i)
#d		var normal = c.getnormal()
		#if c.get_collider() is CharacterBody2D:
			#var push_force = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE
			#c.get_collider().apply_central_impulse(-c.normal * push_force)
			
	
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
					var pushforce = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE
					other.global_position += -normal * pushforce * delta
					#print("We did this instead") #in fact, we did do this (T_T)
					#took so long to debug
				#elif other is StaticBody2D:
					#var bounce_normal = normal.normalized()
					#velocity = velocity.bounce(bounce_normal) * bounce_strength
					#move_and_slide()
					#print("bounce")
					#bounce_timer = 0.15
			
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
	rotation = 0.0
	velocity = Vector2(0.0, 0.0)
	
	%Player1.position = Vector2(220.0, 400.0)
	%Player1.rotation = 0.0
	%Player1.velocity = Vector2(0.0,0.0)
	
	

func _on_out_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.name == ("Player2"):
			#game.player_won.emit("PLAYER 1 WINS")
			#print("emitted signal that p1 wins")
			
			score += 1
			emit_signal("p1_score_changed", score)
			_p2_reset_position()
			game._start_timer()
			#print("P2 is OUT")
			if score == game.num_rounds:
				game.result_text = "PLAYER 1 WINS"
				get_tree().change_scene_to_file("res://Winner.tscn")
			
			#var label = get_node("Winner/MarginContainer/CenterContainer/VBoxContainer/Result")
			#label.text = "Player 1 Wins!"
