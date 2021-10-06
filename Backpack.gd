extends Node

export(String) var DefinitionFilePath = "res://inventory_definition.json"
export(int) var Width = 3	
export(int) var Height = 3

onready var grid = []

func _ready():
	# generate inventory grid
	for i in Width * Height:
		grid.append([])

func get_grid_position(index):
	return Vector2(index % Width, index / Width)

func get_grid_index(vec2):
	return vec2.y * Width + vec2.x

func to_string():
	var print_value = ""
	for index in Width * Height:
		var cell = "[%d](%d,%d):%s\t"
		print_value += cell % \
			[index,
			get_grid_position(index).x,  
			get_grid_position(index).y,
			grid[index]]
		if index and not ((index+1) % Width):
			print_value += "\n"
	return print_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
