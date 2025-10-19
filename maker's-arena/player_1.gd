extends CharacterBody2D

const SPEED = 36200.0
var PUSH_FORCE := 400.0
var MIN_PUSH_FORCE := 250.0
const ROTATION_SPEED := 5.2
var bounce_strength := 0.6
var bounce_timer := 0.0
var good_to_bounce

signal p2_score_changed(new_score)
var score := 0

const p1_xi := 220.0
const p1_yi := 400.0

func _good_to_bounce() -> void:
	if is_on_ceiling() or is_on_wall() or is_on_floor():
		good_to_bounce = true
	else:
		good_to_bounce = false

func _physics_process(delta: float) -> void:
	
	if game.solo_mode:
		PUSH_FORCE = 400.0
		MIN_PUSH_FORCE = 300.0
	else:
		PUSH_FORCE = 300.0
		MIN_PUSH_FORCE = 250.0
	
	var input_velocity := Vector2.ZERO
	
	if game.allow_arena_input:
		if Input.is_action_pressed("a"):
			rotation -= ROTATION_SPEED * delta
		if Input.is_action_pressed("d"):
			rotation += ROTATION_SPEED * delta
		
		if Input.is_action_pressed("w"):
			input_velocity = Vector2.UP.rotated(rotation) * SPEED # * delta
		elif Input.is_action_pressed("s"):
			input_velocity = Vector2.UP.rotated(rotation) * -SPEED # * delta
		else:
			input_velocity = Vector2.ZERO
	#else:
		#rotation = 0.0
		#input_velocity = Vector2.ZERO
	
	velocity = input_velocity * delta
	move_and_slide()
	good_to_bounce = false

	var collision_count = get_slide_collision_count()
	
	if collision_count > 0:
		#print("Collision count: ", collision_count)
		for i in range(collision_count):
			var c = get_slide_collision(i)
			
			if typeof(c) == TYPE_OBJECT and c is KinematicCollision2D:
				var normal := c.get_normal()
				var other := c.get_collider()
				
				if other is CharacterBody2D:
					var pushforce = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE
					other.global_position += -normal * pushforce * delta
					#print("We did this instead") #in fact, we did do this (T_T)
					#took so long to debug
				elif other is RigidBody2D:
					var bounce_normal = normal.normalized()
					velocity = velocity.bounce(bounce_normal) * bounce_strength
					print("bounce da rigid")
					good_to_bounce = true
					move_and_slide()

func _p1_reset_position() -> void:
	position = Vector2(p1_xi, p1_yi)
	rotation = 0.0
	velocity = Vector2(0.0, 0.0)
	
	%Player2.position = Vector2(930.0, 400.0)
	%Player2.rotation = 0.0
	%Player2.velocity = Vector2(0.0,0.0)

func _on_out_area_2d_body_entered(body: Node2D) -> void:
	var num_rounds = game.num_rounds
	if body is CharacterBody2D:
		if body.name == ("Player1"):
			score += 1
			emit_signal("p2_score_changed", score)
			_p1_reset_position()
			game._start_timer()
			#print("P1 is OUT")
			#NEED TO INCREMENT POINTS AND UPDATE SCOREBOARD FIRST
			
			if score == num_rounds:
				game.result_text = "PLAYER 2 WINS"
				get_tree().change_scene_to_file("res://Winner.tscn")
			

# idk i think this appeared when i connected from arena
#func _on_arena_p_1_score_changed(_p1_update_score: Variant):
	#pass # Replace with function body.
