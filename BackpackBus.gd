extends Node2D

# Service class to allow communication (mainly items transfer between
# more inventories). This class exists for technical reason and should
# not be used directory. In order for Backpack to work you must autoload
# this class as a singleton with name "_backpackbus"

var selected_stack = []
var icon = null
var follow_mouse
	
func _process(_delta):
	if selected_stack and icon:
		if not follow_mouse:
			follow_mouse = TextureRect.new()
			follow_mouse.texture = icon
			follow_mouse.mouse_filter = Control.MOUSE_FILTER_IGNORE
			VisualServer.canvas_item_set_z_index(
					follow_mouse.get_canvas_item(), 10)
			add_child(follow_mouse)
		follow_mouse.rect_position = get_global_mouse_position()
	elif not selected_stack and follow_mouse:
		follow_mouse.queue_free()
		follow_mouse = null
		
func get_selected_stack(): 
	return selected_stack

