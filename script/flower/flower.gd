extends Node2D

@export var color = ""

var flower_color = {
	"gold" : {"text" : "Aurelia's Blossom", "src" : "res://asset/graphic/flower/golden_flower.png"},
	"silver" : {"text" : "Iron Petal", "src" : "res://asset/graphic/flower/silver_flower.png"},
	"rose" : {"text" : "Everbloom", "src" : "res://asset/graphic/flower/rose gold.png"},
	"violet": {"text" : "Lumina Lily", "src" : "res://asset/graphic/flower/violet_flower.png"},
}

var flower_name
var flower_path

func _ready() -> void:
	# Correctly setting the Sprite2D texture
	var sprite_node = $FlowerSprite
	if sprite_node:
		flower_path = flower_color[color]["src"]
		sprite_node.texture = load(flower_path)
		flower_name = flower_color[color]["text"]
	else:
		print("Error: Sprite2D node not found.")
	
