extends Label

onready var handle = get_node("../../..")
var drag = false
var _mouse_offset = null

func _process(_delta):
	if drag:
		if not _mouse_offset: _mouse_offset = get_global_mouse_position() - handle.position
		handle.position = get_global_mouse_position() - _mouse_offset
	else:
		_mouse_offset = null

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drag = event.pressed
