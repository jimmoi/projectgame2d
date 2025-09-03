extends CharacterBody2D

# The speed of the character
@export var speed = 15.0
signal near_flower_signal(text_visible)
signal pick_flower_signal(text_visible, path)
signal atomic
var flower = null

func _ready() -> void:
	#Get the viewport size
	var window_size = get_viewport_rect()
	$walk_sound.play()
	# Set the initial position to the center of the screen
	#position = window_size.size / 2
	pass


	
	

func _process(delta: float) -> void:
	movement()
	if (flower != null) and (Input.is_key_pressed(KEY_E)):
		pick_flower_signal.emit(flower.flower_name, flower.flower_path)

func movement() -> void:
	var input_direction = Vector2.ZERO
	
	# Get input from keyboard
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		$walk_sound.stream_paused = false
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
		$walk_sound.stream_paused = true
		
	# Normalize the vector to prevent faster diagonal movement
	velocity = input_direction.normalized() * speed
	
	# Call the built-in Godot function to move the character
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("flower"):
		flower = area.get_parent()
		near_flower_signal.emit(true, flower.flower_name)
		
			
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("flower"):
		near_flower_signal.emit(false, area.get_parent().flower_name)
		flower = null
