extends StaticBody3D
@onready var flush = $AudioStreamPlayer3D

func interact():
	flush.play()
