extends StaticBody3D

@onready var wash = $AudioStreamPlayer3D

func interact():
	wash.play()
