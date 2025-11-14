extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 4.5

@onready var char = $"../CharacterBody3D"

@onready var animPlr = $AnimationPlayer

@export var canAttack = true
var gravityEnabled = true

@export var stunned = false

var a

func On() -> void: 
	$"Character Model/Pivot/MeshInstance3D/Area3D".monitoring = true
	
func Off() -> void: 
	$"Character Model/Pivot/MeshInstance3D/Area3D".monitoring = false


func move(direction) -> void:
	#if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

func checkAtk() -> void:
	if position.distance_to(char.position) < 10 and stunned == false:
		#print(position.distance_to(char.position))
		#animPlr.stop()
		animPlr.play("Attack")
		
		



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and gravityEnabled:
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction
	if not stunned:
		direction = (char.position - position).normalized()
	else:
		direction = Vector3(0,0,0)
	move(direction)
	#print(velocity)
	
	
	checkAtk()
	move_and_slide()
