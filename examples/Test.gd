extends Node2D

onready var inventory = get_node("Backpack")
onready var gun = get_node("Beretta")

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.add_item(gun)

