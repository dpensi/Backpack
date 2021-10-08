extends Node2D

# Main class to access inventory functions

export(String) var DefinitionFilePath = "res://inventory_definition.json"
export(NodePath) var BackEndPath
export(PackedScene) var SlotScene

var width: int	
var height: int
var selected_stack = []
var definitions

onready var grid 
onready var backend 

func _ready():
	grid = get_node("Inventory/VBoxContainer/GridContainer")
	backend = get_node(BackEndPath)
	# loading inventory definition from backend
	definitions = backend.definitions
	
	# setting the inventory name
	get_node("Inventory/VBoxContainer/Title").text = backend.Name
	
	# connecting signals from backend
	backend.connect("item_added", self, "on_item_added")
	
	# getting width and height from backend
	width = backend.Width
	height = backend.Height
	
	# setting the inventory XY grid
	grid.columns = width
	var child_index = 0
	for _col in range(width * height):
		var slot = SlotScene.instance()
		slot.definitions = definitions
		slot.grid_position = Vector2(
				child_index % width,
				child_index / width
		)
		child_index += 1
		slot.connect("stack_in", self, "on_Slot_stack_in")
		slot.connect("stack_out", self, "on_Slot_stack_out")
		grid.add_child(slot)

func on_item_added(item, index):
	var slot = grid.get_child(index)
	if slot.is_free:
		slot.add_item(item)
		print("item added")
			
func on_Slot_stack_in(stack, grid_position):
	backend.add_stack_to(stack, grid_position)

func on_Slot_stack_out(grid_position):
	backend.remove_stack_from(grid_position)
	
	
	
