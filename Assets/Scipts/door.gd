extends Node3D

var doorNum = "A-050"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Label3D.text=doorNum


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player": 
		$AnimationPlayer.play("door_opening")
		$Area3D.queue_free()
