extends Node2D

onready var inventory0 = get_node("BackpackBus/Backpack")
# onready var inventory1 = get_node("Backpack3")
onready var gun = get_node("Beretta")

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory0.add_item(gun)
	# inventory1.add_item(gun)

