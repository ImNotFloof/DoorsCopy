extends AnimatableBody3D

var player_in_area = false
const damage = 5
var damageBool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#will flicker lights or something
	#looping sound
	pass # Replace with function body.

func _process(delta: float) -> void:
	if $damageInterval.is_stopped():
		damageBool = true
	else:
		damageBool = false
	if player_in_area and damageBool:
		var player = get_tree().current_scene.find_child("Player")
		player.Health -= damage
		$damageInterval.start()
	
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_in_area = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_in_area = false
