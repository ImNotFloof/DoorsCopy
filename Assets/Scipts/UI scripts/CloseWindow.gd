extends Button

@onready var window = $'..'/'..'/'..'/'..'
# Called when the node enters the scene tree for the first time.

func _on_pressed() -> void:
	window.visible = false
	window.closed = true
