extends Area2D

# อ้างอิง Node ผู้เล่น
@onready var player = get_parent().get_node("nobura")

var chase_radius = 150

func _ready() -> void:
		$wall.collision_enabled = false
		$wall.visible = false
		
func _physics_process(delta):
	var distance_to_player = position.distance_to(player.position)

	# ตรวจสอบว่าผู้เล่นอยู่ในระยะไล่ตามหรือไม่
	if distance_to_player <= chase_radius:
		# คำนวณเวกเตอร์ทิศทางจากมอนไปยังผู้เล่น
		var direction = (player.position - position).normalized()
		
		$wall.collision_enabled = true
		$wall.visible = true
