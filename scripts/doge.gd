extends StaticBody3D
@onready var good_boi = $AnimationPlayer
@onready var good_boi_bark = $AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func interact():
	good_boi.play("Good_boi")
	good_boi_bark.play()
	
