class_name Hold extends MiniGame


func _physics_process(delta: float) -> void:
	if score == 100:
		_on_won_game()
		return

	if Input.is_action_pressed("action"):
		score = min(score + delta * 15, Globals.MAX_MINI_GAME_SCORE)
	else:
		score = max(score - delta * 15, 0)