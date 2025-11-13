extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 4.5

@onready var char = $"../CharacterBody3D"

var gravityEnabled = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and gravityEnabled:
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = (char.position - position).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
