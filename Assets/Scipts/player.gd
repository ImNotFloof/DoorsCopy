extends CharacterBody3D

var Health = 100
@onready var currHealth = $UI/CanvasLayer/Label.text.split(" ")

var paused = false
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

@onready var head = %head
@onready var camera = %Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle menu.
	if Input.is_action_just_pressed("pause"):
		print("paused")
		print(paused)
		paused = !paused
		%Desktop.visible = !%Desktop.visible
		if %Desktop.visible:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _process(delta: float) -> void:
	if paused:
		get_tree().paused = true
	if Health <= 0:
		get_tree().paused = true
	if int(currHealth[1]) != Health:
		currHealth[1] = str(Health)
		$UI/CanvasLayer/Label.text = "HEALTH: " + str(Health)

func unpaused():
	print("UNPAUSED!")
	paused = false
	%Desktop.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
