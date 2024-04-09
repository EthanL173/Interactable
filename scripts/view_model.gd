extends Camera3D
@onready var fps_rig = $fps_rig
@onready var anim_player = $fps_rig/rifle/AnimationPlayer
@onready var anim_tree = $fps_rig/rifle/AnimationTree

var is_firing = false
var is_racking = false
var is_idle = true

#Bullet stuff
var bullet = load("res://scenes/bullet.tscn")
var instance
@onready var barrel = $fps_rig/rifle/barrel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fps_rig.position.x = lerp(fps_rig.position.x,0.0,delta*5)
	fps_rig.position.y = lerp(fps_rig.position.y,0.0,delta*5)
	
	if(is_idle):
		anim_tree.set("parameters/conditions/is_idle", is_idle)
	
func sway(sway_amount):
	fps_rig.position.x -= sway_amount.x*0.00005
	fps_rig.position.y += sway_amount.y*0.00005

func _input(event):
	if(is_idle && !is_racking && !is_firing):
		if(event.is_action_pressed("fire")):
			is_idle = false
			is_firing = true
			anim_tree.set("parameters/conditions/is_firing", is_firing)
			instance = bullet.instantiate()
			instance.position = barrel.global_position
			instance.transform.basis = barrel.global_transform.basis
			get_parent().add_child(instance)
			await get_tree().create_timer(0.5).timeout
			is_firing = false
			anim_tree.set("parameters/conditions/is_firing", is_firing)
			is_racking = true
			if(is_racking && !is_idle && !is_firing):
				anim_tree.set("parameters/conditions/is_racking", is_racking)
				await get_tree().create_timer(0.8).timeout
				is_racking = false
				anim_tree.set("parameters/conditions/is_racking", is_racking)
				is_idle = true






