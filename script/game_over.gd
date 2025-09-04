extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("cut_scene")
	$sfx.single_sfx_player.play()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/map_khong.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
