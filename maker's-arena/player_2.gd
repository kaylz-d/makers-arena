extends CharacterBody2D
#2 do: add pushing mechanic
const SPEED = 46200.0
const PUSH_FORCE := 300.0
const MIN_PUSH_FORCE := 250.0

func _physics_process(delta: float) -> void:
		
	var ROTATION_SPEED := 5.2
	
	if Input.is_action_pressed("left_p2"):
		rotation -= ROTATION_SPEED * delta
	if Input.is_action_pressed("right_p2"):
		rotation += ROTATION_SPEED * delta
		
	if Input.is_action_pressed("up_p2"):
		velocity = Vector2.UP.rotated(rotation) * SPEED * delta
	elif Input.is_action_pressed("down_p2"):
		velocity = Vector2.UP.rotated(rotation) * -SPEED * delta
	else:
		velocity = Vector2.ZERO
		
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
			
			if typeof(c) == TYPE_OBJECT and c is KinematicCollision2D:
				var normal := c.get_normal()
				
				var other := c.get_collider()
				if other is CharacterBody2D:
					var pushforce = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE
					other.global_position += -normal * pushforce * delta
					#print("We did this instead") #in fact, we did do this (T_T)
					#took so long to debug
					
			
			#if c:
				#if c.get_collider() is CharacterBody2D:
					#var push_force = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE
					#c.get_collider().apply_central_impulse(-c.normal * push_force)

signal p1_score_changed(new_score)
var score := 0

func _on_out_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.name == ("Player2"):
			#game.player_won.emit("PLAYER 1 WINS")
			#print("emitted signal that p1 wins")
			
			score += 1
			emit_signal("p1_score_changed", score)
			#print("P2 is OUT")
			if score == 5:
				game.result_text = "PLAYER 1 WINS"
				get_tree().change_scene_to_file("res://Winner.tscn")
			
			#var label = get_node("Winner/MarginContainer/CenterContainer/VBoxContainer/Result")
			#label.text = "Player 1 Wins!"
