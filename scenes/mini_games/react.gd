class_name React extends MiniGame

@onready var timer = $Timer
@onready var ap = $AnimationPlayer 

@export var inversion_amount := 1.0

var reaction_max = .5
var reaction_min = .15
var reaction_window: float
var reaction_multiplier: float
var tween: Tween

func _ready() -> void:
	super._ready()

	Globals.inversion_amount = 1

	reaction_window = reaction_max * (.7 ** Globals.phase)
	reaction_multiplier = 5 * (1.2 ** (Globals.phase + 1))
	print("Reaction window: ", reaction_window, " seconds")
	_on_timer_timeout()

func _physics_process(delta: float) -> void:
	var elapsed = tween.get_total_elapsed_time()
	if Input.is_action_just_pressed("action"):
		var reaction_score = reaction_multiplier/elapsed
		if elapsed < reaction_window:
			score += reaction_score
		else:
			score -= elapsed * pull_speed
	else:
		score -= delta * 5
	elapsed += delta

func _on_timer_timeout() -> void:
	Globals.inversion_amount = 0

	tween = create_tween()
	tween.tween_property(Globals, "inversion_amount", 1, reaction_window)
	tween.set_ease(Tween.EASE_OUT)

	timer.wait_time = randf_range(2, 3)
	timer.start()
