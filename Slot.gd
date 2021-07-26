extends Panel

signal left_single_click # TODO add stack params to event

var stack = []
var definitions
var is_free = true
var left_mouse_pressed = false
var _left_mouse_release_probe = false
var _mouse_follow

func _process(_delta):
	if left_mouse_pressed:
		_left_mouse_release_probe = true
	elif _left_mouse_release_probe:
		emit_signal("left_single_click")
		_left_mouse_release_probe = false

func add_item(item):
	if not stack:
		get_node("TextureRect").texture = \
				load(definitions[item.item_id]["icon_path"])
	stack.append(item)

func clear_stack():
	stack = []
	get_node("TextureRect").texture = null
	
func add_stack(new_stack):
	if not stack:
		get_node("TextureRect").texture = \
				load(definitions[new_stack[0].item_id]["icon_path"])
	
	stack.append_array(new_stack)
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			left_mouse_pressed = event.pressed


func _on_Slot_left_single_click():
	if _backpackbus.selected_stack:	# drop
		add_stack(_backpackbus.selected_stack)
		_backpackbus.selected_stack = []
		_backpackbus.icon = null
	elif stack:		# take
		_backpackbus.selected_stack = stack
		_backpackbus.icon = get_node("TextureRect").texture
		clear_stack()


