extends Button

@onready var animationPlayer = %AnimationPlayer



func _on_pressed() -> void:
	animationPlayer.play("ShutDown")
	await animationPlayer.animation_finished
	get_tree().quit()
