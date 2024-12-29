extends MiniGame

func _ready() -> void:
	Globals.inversion_amount = 0
	start_tween()

func start_tween() -> void:
	var tween = create_tween()
	tween.tween_property(Globals, "inversion_amount", 1 - Globals.inversion_amount, 2)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.finished.connect(start_tween)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		var inversion_amount = (Globals.inversion_amount * 2) - 1
		score += delta * (50 * -inversion_amount)
	score -= delta * 5

