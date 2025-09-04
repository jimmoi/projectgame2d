extends Node2D

func _ready() -> void:
	$nobura.play("1")
	$ume.play("1")
	


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/map_god.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
