extends Node2D

var player
var atomic_scene
var is_in_field = false

func _ready() -> void:
	player = $nobura
	$sfx.single_sfx_player.play()
	atomic_scene = $CanvasLayer/Control/I_am_Atomic
	atomic_scene.visible = false
	player.atomic.connect(play_atomic_scene)
	
func play_atomic_scene():
	$sfx.single_sfx_player.stream_paused = true
	atomic_scene.visible = true
	atomic_scene.play_cut_scen()
	await  get_tree().create_timer(20).timeout
	$sfx.single_sfx_player.stream_paused = false
	$gate2.enable_door()
