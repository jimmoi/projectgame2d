extends Node2D


func _on_trigger_area_entered(area: Area2D) -> void:
	$CanvasLayer/AnimationPlayer/ColorRect.visible = true
	$CanvasLayer/AnimationPlayer/Label.visible = true
	$CanvasLayer/AnimationPlayer.play("1")
	await get_tree().create_timer(12).timeout
	get_tree().change_scene_to_file("res://peace/scene/ending.tscn")
	
