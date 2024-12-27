class_name Mash extends MiniGame


func _physics_process(delta: float) -> void:
	if score == Globals.MAX_MINI_GAME_SCORE:
		_on_won_game()

	if Input.is_action_just_pressed("action"):
		score += 10
	
	score -= delta * 10

	score = clamp(score, 0, Globals.MAX_MINI_GAME_SCORE)