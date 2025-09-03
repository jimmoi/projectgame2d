extends Node2D

var player
var sfx
var text
var ui_text

var can_exit = false
var near_door = false
var is_exit = false

func _ready() -> void:
	play_cut_scene()
	player = $nobura
	sfx = $sound
	
	ui_text = $CanvasLayer/Control/Objective
	ui_text.text = "I must get her the most beautiful flower."
	ui_text.visible = true
	
	text = $CanvasLayer/Control/Interact
	text.text = ""
	text.visible = false
	
	
	
	player.near_flower_signal.connect(show_text)
	player.pick_flower_signal.connect(destroy_all_flower)
	
func _process(delta: float) -> void:
	if near_door and can_exit and (Input.is_key_pressed(KEY_E)) and not is_exit:
		#get_tree().change_scene_to_packed(next_scene) map_khong
		is_exit = true
		print("go to map khong")
		sfx.get_node("aaa").single_sfx_player.play()
		

func play_cut_scene():
	$CanvasLayer.visible=false
	$CanvasModulate.visible=false
	
	$AnimationPlayer/Label.visible = true
	$AnimationPlayer/ColorRect.visible = true
	$AnimationPlayer.play("1")
	await get_tree().create_timer(10).timeout
	$AnimationPlayer.pause()
	$AnimationPlayer/Label.visible = false
	$AnimationPlayer/ColorRect.visible = false
	
	$CanvasLayer.visible=true
	$CanvasModulate.visible=true
	$sound/night_forest_sound.play()
			
	
func show_text(visible, flower_name):
	text.text = "Press 'E' to pick up " + '"' +flower_name + '"'
	text.visible = visible
	
func destroy_all_flower(flower_name, flower_path):
	sfx.get_node("pop").single_sfx_player.play()
	$flower.queue_free()
	await get_tree().create_timer(0.1).timeout
	text.text = 'You have picked the "' + flower_name + '"!!'
	
	
	$CanvasLayer/Control/TextureRect.texture = load(flower_path)
	ui_text.visible = false	
	
	
	text.visible = true
	await get_tree().create_timer(2.5).timeout
	text.visible = false
	
	ui_text.text = "Let's go back to the hole and ahead to the castle then bring it to her."
	ui_text.visible = true	
	
	can_exit = true
	
	


func _on_door_area_entered(area: Area2D) -> void:
	near_door = true
	if can_exit:
		text.text = "Press 'E' to exit"
	else:
		text.text = "You can not exit yet."
	text.visible = true
		


func _on_door_area_exited(area: Area2D) -> void:
	near_door = false
	text.visible = false
