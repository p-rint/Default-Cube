extends Area3D

var IDs = []

@onready var gameScript: Node = $"../../../../Game"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	await get_tree().create_timer(.5, true).timeout
	queue_free()


func hitCheck(area : Area3D): #make sure hitbox not already hit
	for i in IDs:
		if i == area: #If the area was already detected
			return( false )
		
	IDs.append(area)
	return true # no matches	
	

func _on_area_entered(area: Area3D) -> void:
	if area.monitoring == true:
		
		if hitCheck(area):
			print("entered")
			var ene = area.get_parent()
			if ene.name == "Enemy":
				hit(ene)
			
			

func hit(enemy : CharacterBody3D) -> void:
	enemy.damage(1)
	gameScript.hitFX(enemy.global_position)
	gameScript.hitStop(.2)
	
