extends Control

func _on_group_a_pressed():
	get_tree().change_scene_to_file("res://scenes/level_a.tscn")


func _on_group_b_pressed():
	get_tree().change_scene_to_file("res://scenes/level_b.tscn")


func _on_quit_pressed():
	get_tree().quit()
