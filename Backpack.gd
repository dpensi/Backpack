extends Node

signal item_added(item, index)

export(String) var Name = "Inventory Name"
export(String) var DefinitionFilePath = "res://inventory_definition.json"
export(int) var Width = 3	
export(int) var Height = 3

onready var grid = []

var definitions

func _ready():
	# loading inventory definition from json file
	definitions = load_definition_from_json(DefinitionFilePath)
	if not definitions:
		push_error("failed to get inventory definition, exiting the game")
		get_tree().quit() # TODO provide a default definition?
		return

	# generate inventory grid
	for i in Width * Height:
		grid.append([])
		
func add_item(item):
	# TODO 
	# 1. get item stack size from the definition
	# 2. check item.id == stack[index].id
	# 2.1. true: add to the stack
	# 2.2 false: continue (next stack)
	for i in len(grid):
		if grid[i].size() == 0:
			grid[i].append(item)
			print("appended %s at position %d" % [definitions[item.item_id], i])
			emit_signal("item_added", item, i)
			break

func add_stack_to(stack, position):
	grid[get_grid_index(position)].append_array(stack)
	print(to_string())
	
func remove_stack_from(position):
	grid[get_grid_index(position)] = []
	print(to_string())
	
func load_definition_from_json(file_path):
	var file = File.new() 
	var err = file.open(file_path, File.READ)
	if err:
		var err_msg = "error opening dictionary, err no: {no}"
		err_msg += ".did you provide a valid DefinitionFilePath to {name}?"
		push_error(err_msg.format({"name": name, "no": err}))
		return null
	
	var content = file.get_as_text()
	file.close()
	
	var parsed = JSON.parse(content)
	if parsed.error:
		var format_error = "load_dictionary_from_json failure " 
		format_error += "err no: {errno}, {errstring} at line: {errline}"
		var error = format_error.format(
			{"errno": str(parsed.error),
			"errstring": str(parsed.error_string),
			"errline": str(parsed.error_line)}) 
		push_error(error)
		return null
	
	return parsed.result

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
