class_name Mash extends MiniGame


func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("action"):
		score += 10
	
	score -= delta * 10
