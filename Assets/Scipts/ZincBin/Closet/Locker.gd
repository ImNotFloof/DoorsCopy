extends Area3D

@onready var pos1 = $"../Innie".global_position
@onready var pos2 = $"../Outtie".global_position

func interact():
	var tween = create_tween()
	if Global.SFDMG == false:
		Global.SFDMG = true
		tween.tween_property($"../../Player", "position", Vector3(pos1), 0.5)
		$"../Timer".start()
	elif Global.SFDMG == true and $"../Timer".is_stopped():
		tween.tween_property($"../../Player", "position", Vector3(pos2), 0.5)
		Global.SFDMG = false
		
