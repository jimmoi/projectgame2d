extends CharacterBody2D

# The speed of the character
@export var speed = 15.0

func _ready() -> void:
	 #Get the viewport size
	var window_size = get_viewport_rect()
	# Set the initial position to the center of the screen
	#position = window_size.size / 2
	pass
	
func _physics_process(delta: float) -> void:
	movement()

func movement() -> void:
	var input_direction = Vector2.ZERO
	
	# Get input from keyboard
	if Input.is_action_pressed("up"):
		input_direction.y -= 1
		$AnimatedSprite2D.play("up")
	elif Input.is_action_pressed("down"):
		input_direction.y += 1
		$AnimatedSprite2D.play("down")
	elif Input.is_action_pressed("left"):
		input_direction.x -= 1
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("side")
	elif Input.is_action_pressed("right"):
		input_direction.x += 1
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("side")
	else:
		$AnimatedSprite2D.pause()
		
	# Normalize the vector to prevent faster diagonal movement
	velocity = input_direction.normalized() * speed
	
	# Call the built-in Godot function to move the character
	move_and_slide()
	
	



func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("enter")
	#if area.is_in_group("flower"):
		## Your code here for when a flower enters the area.
		#print("A flower has entered the area!")
		
	# Print the name of the area that entered
	print("Area entered: ", area.name)
	
	# Print all the groups the entered area belongs to
	print("Groups of the entered area: ", area.get_groups())
	
	if area.is_in_group("flower"):
		print("A flower has entered the area!")
	else:
		print("The entered area is not in the 'flower' group.")


func _on_area_2d_area_exited(area: Area2D) -> void:
	print("exit")
	if area.is_in_group("flower"):
		# Your code here for when a flower exits the area.
		print("A flower has exited the area!")
