extends Button

@onready var button = $'.'

var coorWindow
var coorTab
const theming = preload("res://Assets/MISC/windows_95.tres")
const tabScript = preload("res://Assets/Scipts/UI scripts/Tab.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	
	coorWindow = %Windows.find_child(button.name)
	coorWindow.closed = false
	coorWindow.visible = !coorWindow.visible
	coorWindow.move_to_front()
	
	#Makes tab if tab isnt found
	if coorTab == null or not %Tabs.find_child(button.name):
		
		coorTab = Button.new()
		coorTab.set_script(tabScript)
		coorTab.name = button.name
		
		%Tabs.add_child(coorTab)
		coorTab.owner = owner
		coorTab.creator = self
		coorTab.setup_node()
		
		coorTab.toggle_mode = true
		coorTab.button_pressed = coorWindow.visible
		coorTab.icon = button.icon
		coorTab.text = button.name
		coorTab.theme = theming
	
	
