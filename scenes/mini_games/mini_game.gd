class_name MiniGame extends Node2D

signal won()
signal lost()

@export var difficulty = 1

var score = 0.0

func _ready() -> void:
	Globals.inversion_amount = 0


func _process(_delta: float) -> void:
	score = clamp(score, -Globals.MAX_MINI_GAME_SCORE, Globals.MAX_MINI_GAME_SCORE)
	if score >= Globals.MAX_MINI_GAME_SCORE:
		_on_won_game()
	elif score <= -Globals.MAX_MINI_GAME_SCORE:
		_on_lost_game()

func _on_won_game() -> void:
	won.emit()

func _on_lost_game() -> void:
	lost.emit()
