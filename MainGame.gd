extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if $Timers/HitStop.time_left > 0:
		Engine.time_scale = 0
	else:
		Engine.time_scale = 1
	

func hitStop(time : float) -> void:
	$Timers/HitStop.start(time)
