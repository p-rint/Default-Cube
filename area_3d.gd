extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area3D) -> void:
	if not area.name == "PlayerHitbox": #Enemy hitbox
		var enemy = area.get_parent().get_parent()
		#print("Area")
		enemy.Health -= 25
		enemy.hurt()
