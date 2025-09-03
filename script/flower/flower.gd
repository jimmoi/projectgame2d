extends Node2D

@export var color = ""

var flower_color = {
	"gold" : {"text" : "Golden Flower", "src" : "res://asset/graphic/flower/golden_flower.png"},
	"silver" : {"text" : "Silver Flower", "src" : "res://asset/graphic/flower/silver_flower.png"},
	"rose" : {"text" : "Rose Gold Flower", "src" : "res://asset/graphic/flower/rose gold.png"},
	"violet": {"text" : "Violet Flower", "src" : "res://asset/graphic/flower/violet_flower.png"},
}

var text

func _ready() -> void:
	# Correctly setting the Sprite2D texture
	var sprite_node = $FlowerSprite
	if sprite_node:
		sprite_node.texture = load(flower_color[color]["src"])
		text = flower_color[color]["text"]
	else:
		print("Error: Sprite2D node not found.")
