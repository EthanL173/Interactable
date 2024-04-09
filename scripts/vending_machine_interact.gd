extends StaticBody3D
var instance
var snack = load("res://scenes/snack.tscn")
@onready var vendWAV = $AudioStreamPlayer3D

@onready var drop = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact():
	instance = snack.instantiate()
	instance.position = drop.global_position
	instance.transform.basis = drop.global_transform.basis
	vendWAV.play()
	get_parent().add_child(instance)
