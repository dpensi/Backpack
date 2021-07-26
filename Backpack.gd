extends Node2D

export(String) var DefinitionFilePath = "res://inventory_definition.json"
export(String) var Name = "Inventory Name"
export(int) var Height = 3
export(int) var Width = 3	
export(PackedScene) var SlotScene

var selected_stack = []
onready var grid = get_node("Inventory/VBoxContainer/GridContainer")

func _ready():
	grid.columns = Width

	var definitions = load_definition_from_json(DefinitionFilePath)
	if not definitions:
		push_error("failed to get inventory definition, exiting the game")
		get_tree().quit()
		return
		
	get_node("Inventory/VBoxContainer/Title").text = Name
	for _col in range(Width * Height):
		var slot = SlotScene.instance()
		slot.definitions = definitions
		grid.add_child(slot)

func add_item(item):
	for i in range(grid.get_child_count()):
		var slot = grid.get_child(i)
		if slot.is_free:
			slot.add_item(item)
			break
			
func load_definition_from_json(file_path):
	var file = File.new() 
	var err = file.open(file_path, File.READ)
	if err:
		push_error("error opening dictionary, err no: {no}".format({"no":err}))
		push_error("did you provide a valid DefinitionFilePath to {name}?".format({"name": name}))
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
	
	
	
	
