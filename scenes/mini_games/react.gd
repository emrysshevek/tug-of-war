class_name React extends MiniGame

@onready var timer = $Timer
@onready var ap = $AnimationPlayer 

@export var inversion_amount := 0.0

var elapsed_time := 10.0

func _ready() -> void:
	super._ready()
	inversion_amount = Globals.inversion_amount
	timer.wait_time = randf_range(1, 3)
	timer.start()

func _physics_process(delta: float) -> void:
	Globals.inversion_amount = inversion_amount
	if Input.is_action_just_pressed("action"):
		if elapsed_time >= .5:
			score -= delta * 3000
		else:
			score += (1 - elapsed_time) * delta * 3000

	elapsed_time += delta

func _on_timer_timeout() -> void:
	ap.play("flash_black")
	elapsed_time = 0
	timer.wait_time = randf_range(1, 2)
	timer.start()