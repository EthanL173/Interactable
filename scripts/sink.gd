extends StaticBody3D

@onready var wash = $AudioStreamPlayer3D

var play = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func interact():
	play = !play
	if(play == true):
		wash.play()
	elif (play == false):
		wash.stop()
