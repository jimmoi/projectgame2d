extends Node2D


func _ready() -> void:
	$AnimationPlayer.play('1')
	$ara_ara.single_sfx_player.play()
