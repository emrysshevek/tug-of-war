extends Node

signal heart_hit()

@export var MAX_MINI_GAME_SCORE = 100

@export var MAX_WINS := 10
@export var MAX_LOSSES := 3

@export var current_side := 0

@export var score := 0

@export var phase := 0
@export var phase_score := 0
@export var last_winner := 0

@export var inversion_amount := 0.0

func update_from_winner(winner: int) -> void:
	Globals.score += winner
	Globals.phase_score += winner
	Globals.last_winner = winner

func on_heart_hit() -> void:
	heart_hit.emit()