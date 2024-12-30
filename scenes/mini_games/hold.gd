class_name Hold extends MiniGame


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		score = score + delta * base_pull_speed
	else:
		score = score - delta * pull_speed