extends Node2D

# This variable will store the sound name (e.g., "pop")
@export var sound: String = ""

# A dictionary to map sound names to file paths
var sfx_files = {
	"pop" : "res://asset/sound/pop.mp3",
	"warp" : "res://asset/sound/warp.mp3",
	"walk_dirt" : "res://asset/sound/walk_dirt.mp3",
	"walk_grass" : "res://asset/sound/walk_grass.mp3",
	"aaa" : "res://asset/sound/aaa.mp3"
}

# The AudioStreamPlayer2D nodes are set up in the editor,
# and we get a reference to them here for easy access.
@onready var single_sfx_player: AudioStreamPlayer2D = $single
@onready var loop_sfx_player: AudioStreamPlayer2D = $loop

func _ready() -> void:
	if not sound.is_empty() and sfx_files.has(sound):
		var sfx_stream = load(sfx_files[sound])
		single_sfx_player.stream = sfx_stream
		loop_sfx_player.stream = sfx_stream
		loop_sfx_player.connect("finished", _on_loop_finished)
		print("Audio files loaded successfully.")
	else:
		# Print an error message if the sound name is invalid or not set.
		print("Error: Invalid or missing sound name in 'sound' variable.")



func _on_loop_finished() -> void:
	loop_sfx_player.play()
