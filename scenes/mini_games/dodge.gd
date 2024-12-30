extends MiniGame

@onready var shooters: Array[Shooter] = [$Shooter, $Shooter2, $Shooter3, $Shooter4, $Shooter5, $Shooter6]

func _ready() -> void:
	super._ready()
	Globals.heart_hit.connect(_on_heart_hit)
	var n_shooters = min((Globals.phase + 1) * 2, len(shooters))
	print(n_shooters)
	for i in range(n_shooters):
		shooters[i].start_auto_shoot()
		if randf() < .5:
			shooters[i].shoot()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		score += delta * pull_speed
	else:
		score -= delta * pull_speed

func _on_heart_hit() -> void:
	if Input.is_action_pressed("action"):
		score -= pull_speed
