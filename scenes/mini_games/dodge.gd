extends MiniGame

@onready var shooter: Shooter = $Shooter

func _ready() -> void:
	super._ready()
	Globals.heart_hit.connect(_on_heart_hit)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		score += 10
	
	score -= delta * 10

func _on_heart_hit() -> void:
	score -= 10
