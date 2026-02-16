extends GPUParticles3D

@onready var player = $"../../../Player"

var rot : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	var toPlr = (player.global_position - global_position).normalized()
	rotation.y = atan2(toPlr.x, toPlr.z)
	
	emitting = true
	$GPUParticles3D.emitting = true
	await finished


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
