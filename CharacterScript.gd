extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravityEnabled = true

@export var Health = 100

@onready var animPlr = $AnimationPlayer

var attackTable = ["attack", "attack2", "attack3", "attack4"]

var comboNum = 0

#@onready var enemy = $"../EnemyBody3D"
#@onready var enemyAnimPlr = $"../EnemyBody3D/AnimationPlayer"

func also() -> void:
	if velocity.is_finite():
		print("I like doggyies")
	pass

func  isDead() -> void:
	if Health <= 0:
		print("PlrDead")
		get_tree().reload_current_scene()

func attack() -> void:
	
	velocity.z = -50

func attack2() -> void:
	velocity.z = -50
	
func attack3() -> void:
	velocity.z = -20
	
func attack4() -> void:
	
	velocity.z = -30

func On() -> void: 
	$"Character Model/Pivot/MeshInstance3D/Area3D".monitoring = true
	
func Off() -> void: 
	$"Character Model/Pivot/MeshInstance3D/Area3D".monitoring = false


func hurt(enemy  : CharacterBody3D) -> void:
	var hitVel = (position - enemy.position).normalized()
	hitVel.y = 0
	velocity = hitVel * 40
	move_and_slide()
	


func comboManager() -> void:
	
	if comboNum < attackTable.size():
		animPlr.play(attackTable[comboNum])
		comboNum += 1
	else:
		animPlr.play(attackTable[0])
		comboNum = 1 #you did the 1st attack, so move on to 2nd
	print(comboNum)
	



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and gravityEnabled:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Attack") and is_on_floor():
		animPlr.stop()
		comboManager()
		
	if Input.is_action_just_pressed("Attack2") and is_on_floor():
		animPlr.stop()
		animPlr.play("attack2")
	if Input.is_action_just_pressed("Attack3") and is_on_floor():
		animPlr.stop()
		animPlr.play("attack3")
	if Input.is_action_just_pressed("Attack4") and is_on_floor():
		animPlr.stop()
		animPlr.play("attack4")
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	isDead()
