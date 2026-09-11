extends Button

@onready var texts = $".."/".."/".."/"Text holder"/"ColorRect"/"Control"
var coorText
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coorText = texts.find_child($'.'.name)
	$'.'.pressed.connect(_on_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$'.'.button_pressed = coorText.visible
	
func _on_pressed():
	texts.propagate_call("set_visible", [false])
	texts.visible = true
	coorText.propagate_call("set_visible", [true])
	
