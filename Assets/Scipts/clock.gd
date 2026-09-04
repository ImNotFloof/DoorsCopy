extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time_dict = Time.get_datetime_dict_from_system()
	var time_string = "%02d:%02d" % [time_dict["hour"], time_dict["minute"]]
	$'.'.text = time_string
