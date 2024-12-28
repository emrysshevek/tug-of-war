extends Node

signal heart_hit()

@export var MAX_MINI_GAME_SCORE = 100

@export var MAX_WINS := 10
@export var MAX_LOSSES := 3

@export var wins := 0
@export var losses := 0

@export var inversion_amount := 0.0

func on_heart_hit() -> void:
	heart_hit.emit()