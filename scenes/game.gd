class_name Game extends Node2D

@onready var bar = $CanvasLayer/Control/ProgressBar

const MAX_SCORE = 100

var score = 0.0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		score = min(score + delta * 10, MAX_SCORE)
	else:
		score = max(score - delta * 10, 0)

func _process(delta: float) -> void:
	bar.value = score