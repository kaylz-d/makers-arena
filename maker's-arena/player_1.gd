extends CharacterBody2D

#const SPEED := 200.0
#const ACCELERATION := 800.0
#const FRICTION := 600.0
#var VELOCITY: Vector2 = Vector2.ZERO
#
#func _input(event: InputEvent) -> void:
	#var input = Vector2.ZERO
	#
	#input.x = Input.get_action_strength("d") - Input.get_action_strength("a")
	#input.y = Input.get_action_strength("s") - Input.get_action_strength("w")
	#
	#if input != Vector2.ZERO:
		#position += input*32
#
const SPEED = 46200.0
#const JUMP_VELOCITY = -400.0
const PUSH_FORCE := 300.0
const MIN_PUSH_FORCE := 250.0

signal p2_score_changed(new_score)
var score := 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#var direction := Input.get_axis("w", "s")
	#if direction:
		#velocity.y = direction * SPEED
	#else:
		#velocity.y = move_toward(velocity.y, 0, SPEED)
		#
	#var isRotating := Input.get_axis("a", "d")
	#if isRotating:
		#rotation = isRotating * SPEED
		
	var ROTATION_SPEED := 5.2
	
	if Input.is_action_pressed("a"):
		rotation -= ROTATION_SPEED * delta
	if Input.is_action_pressed("d"):
		rotation += ROTATION_SPEED * delta
		
	if Input.is_action_pressed("w"):
		velocity = Vector2.UP.rotated(rotation) * SPEED * delta
	elif Input.is_action_pressed("s"):
		velocity = Vector2.UP.rotated(rotation) * -SPEED * delta
	else:
		velocity = Vector2.ZERO
	move_and_slide()

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

func _on_out_area_2d_body_entered(body: Node2D) -> void:
	var num_rounds = game.num_rounds
	if body is CharacterBody2D:
		if body.name == ("Player1"):
			score += 1
			emit_signal("p2_score_changed", score)
			#print("P1 is OUT")
			#NEED TO INCREMENT POINTS AND UPDATE SCOREBOARD FIRST
			
			if score == num_rounds:
				game.result_text = "PLAYER 2 WINS"
				get_tree().change_scene_to_file("res://Winner.tscn")
			

# idk i think this appeared when i connected from arena
#func _on_arena_p_1_score_changed(_p1_update_score: Variant):
	#pass # Replace with function body.
