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
