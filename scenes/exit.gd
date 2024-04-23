extends Area3D


func _on_body_entered(body):
	get_tree().quit()
