extends RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var coll = self.get_collider()
	
	if self.is_colliding():
		if Input.is_action_just_pressed("interact"):
			if coll.is_in_group("Interactable"):
				coll.interact()
		
		if coll.is_in_group("Interactable"):
			$Interact.show()
	else:
		$Interact.hide()
