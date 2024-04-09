extends CharacterBody3D

var player = null
var state_machine

const SPEED = 4.0
const ATACK_RANGE = 2.5

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D

@onready var anim_tree = $AnimationTree

var bot_health = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	velocity = Vector3.ZERO
	
	match state_machine.get_current_node():
		'Running':
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		'Punch-loop':
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	
	
	
	
	anim_tree.set('parameters/conditions/is_attacking', _target_in_range())
	anim_tree.set('parameters/conditions/is_running', !_target_in_range())
	
	anim_tree.get("parameters/playback")
	
	
	move_and_slide()
	
func _target_in_range():
	return global_position.distance_to(player.global_position) < ATACK_RANGE
	
func _hit_finished():
	var dir = global_position.direction_to(player.global_position)
	var damage = 20
	player.hit(dir, damage)
	
func _is_hit(d):
	bot_health =- d
	if(bot_health <= 0):
		queue_free()

