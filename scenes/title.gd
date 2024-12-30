extends Node2D

var elapsed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# elapsed += delta
	# if elapsed < 5:
	# 	return
	if Input.is_action_just_pressed("action"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
