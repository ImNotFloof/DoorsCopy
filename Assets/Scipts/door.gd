extends Node3D

var Rooms = load("res://Assets/Scenes/TEST SCENES/FowardRoom1.tscn")
var doorNum = null
var nextNum = null
var nextRoom = null
var freeRoom = null
var room = null
var pos = null
var rot = null
@onready var path = get_tree().current_scene.find_child("EntityPathing", true, false)

var MaxRoomInScene = 3 #Counts the unopened door as a room MUST BE HIGHER THAN 2 AT ALL TIMES

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room = get_parent()
	doorNum = room.name
	var number = int(doorNum.split("-")[1])
	nextNum = "A-%03d" % (number+1)
	
	#Gets rid of a room that is far away from current door.
	if number >= MaxRoomInScene:
		freeRoom = "A-%03d" % (number-MaxRoomInScene)
		freeRoom = get_tree().current_scene.find_child("Rooms", false).find_child(freeRoom, true, false)
		
		var secondLastRoom = freeRoom.find_child("Door", true, false).nextRoom
		print(secondLastRoom.name)
		secondLastRoom.find_child("AnimationPlayer", true, false).play("RESET")
		await secondLastRoom.find_child("AnimationPlayer", true, false).animation_finished
		
		freeRoom.find_child("Door", true, false).destroyRoom()
	
	%Label3D.text=doorNum

func expandPath():
	for point in room.get_children():
		if point is Marker3D:
			var newPoint = Vector3(point.global_position)
			var prevPoint = path.curve.get_closest_point(newPoint)
			if prevPoint == newPoint:
				continue
			path.curve.add_point(newPoint)

func shrinkPath():
	for point in room.get_children():
		if point is Marker3D:
			var removePoint = path.curve.get_closest_point(point.global_position)
			
			#find index at vector3:
			for i in range(path.curve.point_count):
				if path.curve.get_point_position(i) == removePoint:
					removePoint = i
					break
			path.curve.remove_point(removePoint)
			
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnRoom():
	$Area3D.queue_free()
	expandPath()
	
	pos = room.find_child("End").global_position
	rot = room.find_child("End").global_rotation
	room.find_child("End").queue_free()
	
	nextRoom = Rooms.instantiate()
	nextRoom.name = nextNum
	
	get_tree().current_scene.find_child("Rooms").add_child(nextRoom)
	
	
	nextRoom.global_position = pos
	nextRoom.global_rotation = rot
	
func destroyRoom():
	shrinkPath()
	room.queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player": 
		$AnimationPlayer.play("door_opening")
		spawnRoom()
		$Area3D.set_deferred("monitoring", false)
