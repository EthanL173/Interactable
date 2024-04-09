extends Node3D
@onready var damage_overlay = $CanvasLayer/HBoxContainer/damageOverlay


# Called when the node enters the scene tree for the first time.
func _ready():  
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_player_hit():
	damage_overlay.visible = true
	await get_tree().create_timer(0.2).timeout
	damage_overlay.visible = false
