extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_impulse(Vector3(0,0,5))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()
