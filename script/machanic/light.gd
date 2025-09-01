extends PointLight2D

var player
func _ready() -> void:
	player = $".."

func _process(delta: float) -> void:
	if player.velocity.x > 0:
		rotation = (deg_to_rad(0))
	elif player.velocity.x < 0:
		rotation = (deg_to_rad(180))
	elif player.velocity.y < 0:
		rotation = (deg_to_rad(270))
	elif player.velocity.y > 0:
		rotation = (deg_to_rad(90))
