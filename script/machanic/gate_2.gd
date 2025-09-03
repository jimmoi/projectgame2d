extends Node2D

func _ready() -> void:
	$wall.collision_enabled = false
	$wall.visible = false


func _on_field_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$wall.collision_enabled = true
		$wall.visible = true
		$AnimationPlayer.play("open_door")


func _on_door_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
