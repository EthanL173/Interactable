extends Area3D


func _on_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/survey.tscn")
