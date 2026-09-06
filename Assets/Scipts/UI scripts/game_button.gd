extends Button

var ExpPlayer = null

func _ready():
	ExpPlayer = $".."/".."

func _on_pressed() -> void:
	get_tree().paused = false
	if ExpPlayer.name == "Player":
		ExpPlayer.unpaused()
