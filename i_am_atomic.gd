extends Node2D

func _ready() -> void:
	#play_cut_scen()
	pass
	
func play_cut_scen() -> void:
	$VideoStreamPlayer2.play()
	$AnimationPlayer.play("i_am_atomic")
	await get_tree().create_timer(6.0).timeout
	$VideoStreamPlayer.play()
