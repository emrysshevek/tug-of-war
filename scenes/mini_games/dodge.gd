extends MiniGame

@onready var shooter: Shooter = $Shooter

func _ready() -> void:
	super._ready()
	Globals.heart_hit.connect(_on_heart_hit)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		score += delta * pull_speed
	else:
		score -= delta * pull_speed

func _on_heart_hit() -> void:
	score -= pull_speed
