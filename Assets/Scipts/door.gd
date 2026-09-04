extends Node3D

var Rooms = load("res://Assets/Scenes/TEST SCENES/FowardRoom1.tscn")
var doorNum = null
var nextNum = null
var nextRoom = null
var room = null
var pos = null
var rot = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room = get_parent()
	doorNum = room.name
	nextNum = "A-" + str(int(doorNum.split("-")[1])+1)
	
	
	%Label3D.text=doorNum


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnRoom():
	$Area3D.queue_free()
	
	
	pos = room.find_child("End").global_position
	rot = room.find_child("End").global_rotation
	room.find_child("End").queue_free()
	
	nextRoom = Rooms.instantiate()
	nextRoom.name = nextNum
	
	get_tree().current_scene.find_child("Rooms").add_child(nextRoom)
	
	nextRoom.global_position = pos
	nextRoom.global_rotation = rot

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player": 
		$AnimationPlayer.play("door_opening")
		spawnRoom()
		$Area3D.set_deferred("monitoring", false)
		
