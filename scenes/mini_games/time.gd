extends MiniGame

func _ready() -> void:
	super._ready()
	start_tween()

func start_tween() -> void:
	var tween = create_tween()
	tween.tween_property(Globals, "inversion_amount", 1 - Globals.inversion_amount, 2.0 / (2 ** Globals.phase))
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.finished.connect(start_tween)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		var inversion_amount = (Globals.inversion_amount * 2) - 1
		score += delta * (pull_speed * 4 * -inversion_amount)
	else:
		score -= delta * pull_speed

