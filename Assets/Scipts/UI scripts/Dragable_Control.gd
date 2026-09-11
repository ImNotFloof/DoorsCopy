class_name Dragable_Control extends Node

var dragging = false
var offset: Vector2

func _ready():
	self.gui_input.connect(_on_gui_input)

func _process(delta: float) -> void:
	if dragging:
		self.position = get_viewport().get_mouse_position() - offset

func _on_gui_input( event: InputEvent):
	if !dragging and event.is_action_pressed("left_click"):
		var mouse_pos = get_viewport().get_mouse_position()
		offset = mouse_pos - self.position
		dragging = true
		get_viewport().set_input_as_handled()
		$'.'.move_to_front()
	
	if dragging and event.is_action_released("left_click"):
		dragging = false
		get_viewport().set_input_as_handled()
