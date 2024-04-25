extends RigidBody3D
@onready var snack_mesh = $CollisionShape3D/Snack/SM_Prop_Snack_01
@onready var collision = $CollisionShape3D
@onready var crunch = $AudioStreamPlayer3D



# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass

func interact():
	snack_mesh.visible = false
	crunch.play()
	collision.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	queue_free()
