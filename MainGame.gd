extends Node

const hitEffect = preload("res://hit_effect.tscn")

@onready var player: CharacterBody3D = $"../Player"



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
	#await get_tree().create_timer(.06).timeout
	#$Timers/HitStop.start(time)
	pass


func hitFX(pos : Vector3) -> void:
	var new : Node3D = hitEffect.instantiate()
	#new.emitting = true
	var toPlr = (player.global_position - pos).normalized()
	new.rotation.y = atan2(toPlr.x, toPlr.z)
	
	new.global_position = pos
	#new.look_at(player.global_position)
	$Particles.add_child(new)
	
