extends Node2D

var can_enter = false

func _ready() -> void:
	$wall.collision_enabled = false
	$wall.visible = false
	$open.visible = false
	$close.visible = true
	
func enable_door():
	can_enter = true
	$open.visible = true
	$close.visible = false


func _on_field_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		get_parent().is_in_field = true
		$wall.collision_enabled = true
		$wall.visible = true
		#$AnimationPlayer.play("open_door")

func _on_door_area_entered(area: Area2D) -> void:
	if can_enter:
		get_tree().change_scene_to_file("res://peace/scene/map_castle.tscn") # go to peace 
		print("pass")
