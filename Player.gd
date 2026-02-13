extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4

@onready var camPiv: Node3D = $CameraPivot

@export var health = 5
var invulnerable = false

@onready var animPlr : AnimationPlayer = $AnimationPlayer

@onready var Character: Node3D = $Character

var swordHitbox = preload("res://SwordHitbox.tscn")


func _physics_process(delta: float) -> void:
	var camForw = -camPiv.transform.basis.z
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := flatten(camPiv.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		Character.rotation.y = lerp_angle(Character.rotation.y, atan2(velocity.x, velocity.z), delta * 10)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	if Input.is_action_just_pressed("Attack"):
		animPlr.stop()
		animPlr.play("Slash")
		Character.rotation.y = atan2(camForw.x, camForw.z)
	move_and_slide()



func flatten(vec) -> Vector3:
	return vec * Vector3(1,0,1)


func damage(dmg):
	if not invulnerable:
		health -= dmg
		invulnerable = true


func hitBoxOn() -> void:
	#$Character/SwordPiv/Hitbox.monitoring = true
	var new = swordHitbox.instantiate()
	$Character/SwordPiv.add_child(new)
	
	
func hitBoxOff() -> void:
	#$Character/SwordPiv/Hitbox.monitoring = false
	pass
