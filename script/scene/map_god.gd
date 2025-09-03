extends Node2D

var player
var text

func _ready() -> void:
	player = $nobura
	text = $nobura/show_text/Label
	text.text = ""
	text.visible = false
	player.near_flower_signal.connect(show_text)
	player.pick_flower_signal.connect(destroy_all_flower)
	
func show_text(visible, flower_name):
	text.text = "Press E to pick up " + flower_name
	text.visible = visible
	
func destroy_all_flower():
	$flower.queue_free()
	
