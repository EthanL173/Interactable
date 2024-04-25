extends CharacterBody3D

@onready var view_model_camera = $head/Camera3D/SubViewportContainer/SubViewport/view_model_camera

var health = 100

var  speed = 6.0
const  BASE_SPEED = 6.0
const  SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 6.0
const STAGGER = 8.0

var mouse_sense = 0.1
@onready var head = $head
@onready var camera = $head/Camera3D

#headbob stuff
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

#signals
signal player_hit

@onready var ray = $head/Camera3D/RayCast3D
@export var can_interact = true



#FOV change vars
#const BASE_FOV = 75.0
#const FOV_CHANGE = 1.5

func _ready():
	
	if(!can_interact):
		ray.enabled = false
	
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$head/Camera3D/SubViewportContainer/SubViewport.size = DisplayServer.window_get_size()
func _input(event):
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sense))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sense))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		view_model_camera.sway(Vector2(event.relative.x,event.relative.y))
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 19.6


func _physics_process(delta):
	view_model_camera.global_transform = camera.global_transform
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("upward") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("leftward", "rightward", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
		
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = BASE_SPEED
	
	#var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	#var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	#camera.fov = lerp(camera.fov, target_fov, delta * 10.0)
	
	
	move_and_slide()
func _process(delta):
	if health <= 0:
		get_tree().reload_current_scene()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	
func hit(dir, damage):
	emit_signal("player_hit")
	health -= damage
	velocity += dir * STAGGER

