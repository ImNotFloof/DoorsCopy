extends Button

@onready var window = $".."/".."/".."/".."/".."

func _on_pressed() -> void:
	window.visible = false
	window.closed = true
