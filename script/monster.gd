extends CharacterBody2D

# อ้างอิง Node ผู้เล่น
@onready var player = get_parent().get_node("nobura")
# อ้างอิง Node AnimatedSprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D 

var speed = 100 
var chase_radius = 150 

func _physics_process(delta):
	var distance_to_player = position.distance_to(player.position)

	# ตรวจสอบว่าผู้เล่นอยู่ในระยะไล่ตามหรือไม่
	if distance_to_player <= chase_radius:
		# คำนวณเวกเตอร์ทิศทางจากมอนไปยังผู้เล่น
		var direction = (player.position - position).normalized()
		
		# กำหนดความเร็วในการเคลื่อนที่
		velocity = direction * speed
		
		# **ส่วนเพิ่ม Animation (Walk)**
		animated_sprite_2d.play("walk") 
		
		# หันหน้ามอนให้ไปทางทิศทางที่เคลื่อนที่
		if direction.x > 0:
			animated_sprite_2d.flip_h = false # หันไปทางขวา
		else:
			animated_sprite_2d.flip_h = true  # หันไปทางซ้าย

	else:
		# **ส่วนเพิ่ม Animation (Idle)**
		velocity = Vector2.ZERO # หยุดเคลื่อนที่
		animated_sprite_2d.play("idle") 
	
	move_and_slide()
