extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4


@export var health = 5
var invulnerable = false

@onready var animPlr : AnimationPlayer = $AnimationPlayer

@onready var Character: Node3D = $Character

@onready var player: CharacterBody3D = $"../Player"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.x = move_toward(velocity.x, 0, delta * SPEED)
	velocity.z = move_toward(velocity.z, 0, delta * SPEED)
	
	move_and_slide()



func flatten(vec) -> Vector3:
	return vec * Vector3(1,0,1)


func damage(dmg):
	if not invulnerable:
		health -= dmg
		animPlr.play("Stun")
		velocity = flatten(position - player.position).normalized() * 5
