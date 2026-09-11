extends Button

# Called when the node enters the scene tree for the first time.

func _on_toggled(toggled_on: bool) -> void:
	%StartMenu.visible = toggled_on
