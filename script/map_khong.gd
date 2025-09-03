extends Node2D

var player
var atomic_scene

func _ready() -> void:
	player = $nobura
	atomic_scene = $nobura/Camera2D/I_am_Atomic
	atomic_scene.visible = false
	player.atomic.connect(play_atomic_scene)
	
func play_atomic_scene():
	atomic_scene.visible = true
	atomic_scene.play_cut_scen()
