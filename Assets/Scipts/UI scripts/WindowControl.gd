extends Node

var dragging = false
var offset : Vector2
var closed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		self.position = get_viewport().get_mouse_position() - offset

func _on_gui_input(event: InputEvent):
	if !dragging and event.is_action_pressed("left_click"):
		var mouse_pos = get_viewport().get_mouse_position()
		offset = mouse_pos - self.position
		dragging = true
		get_viewport().set_input_as_handled()
		$'.'.move_to_front()
	
	if dragging and event.is_action_released("left_click"):
		dragging = false
		get_viewport().set_input_as_handled()
