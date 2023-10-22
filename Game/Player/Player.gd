extends CharacterBody3D

var mouseSensibility = 1200/10
var captured = true
var mouse_relative_x = 0
var mouse_relative_y = 0
const SPEED = 500
const JUMP_VELOCITY = 450

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	velocity *= delta
	move_and_slide()

func _input(event):
	if event.is_action_pressed("shoot") and not Global.shooting and Global.can_shoot:
		Global.shooting = true
	else:
		Global.shooting = false
	if event.is_action_pressed("ui_cancel"):
		if captured:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			captured = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			captured = true
	if event is InputEventMouseMotion and captured:
		rotation.y -= event.relative.x / mouseSensibility
		$Camera.rotation.x -= event.relative.y / mouseSensibility
		$Camera.rotation.x = clamp($Camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		mouse_relative_x = clamp(event.relative.x, -50, 50)
		mouse_relative_y = clamp(event.relative.y, -50, 10)
