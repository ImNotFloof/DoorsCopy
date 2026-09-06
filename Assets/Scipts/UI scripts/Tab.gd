extends Button

@onready var script_parent = $'.'
var coorWindow
var creator = null

# Called when the node enters the scene tree for the first time.
func setup_node():
	print("hi")
	print(owner)
	
	coorWindow = %Windows.find_child(script_parent.name)
	script_parent.pressed.connect(_on_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	script_parent.button_pressed = coorWindow.visible
	if coorWindow.closed == true:
		creator.coorTab = null
		script_parent.free()
	
	
	
func _on_button_pressed():
	coorWindow.visible = !coorWindow.visible
