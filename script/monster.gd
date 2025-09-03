extends CharacterBody2D

# อ้างอิง Node ผู้เล่น
@onready var player = get_parent().get_node("nobura")
# อ้างอิง Node AnimatedSprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D 
# อ้างอิง Node Area2D ที่ใช้ตรวจจับการชน
@onready var detection_area = $Area2D

@export var speed = 80 
var chase_radius = 150 
var next_scene_path = "res://scene/Game_over/game_over.tscn" # แก้ Path ให้ตรงกับ Scene ที่ต้องการ

func _ready():
	# เชื่อมต่อสัญญาณ body_entered ของ Area2D กับฟังก์ชันที่เราจะสร้างขึ้น
	detection_area.body_entered.connect(_on_body_entered)

func _physics_process(delta):
	if not is_instance_valid(player):
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle")
		move_and_slide()
		return

	var distance_to_player = position.distance_to(player.position)

	# ตรวจสอบว่าผู้เล่นอยู่ในระยะไล่ตามหรือไม่
	if distance_to_player <= chase_radius:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		animated_sprite_2d.play("walk") 
		if direction.x > 0:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
	else:
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle") 
	
	move_and_slide()

# ฟังก์ชันนี้จะถูกเรียกใช้โดยอัตโนมัติเมื่อ body (ผู้เล่น) เข้ามาใน Area2D
func _on_body_entered(body):
	# ตรวจสอบว่า body ที่เข้ามาเป็นผู้เล่นของเราหรือไม่
	if body == player:
		print("ชนแล้ว! กำลังเปลี่ยน Scene...")
		get_tree().change_scene_to_file(next_scene_path)
