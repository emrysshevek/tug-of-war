class_name MiniGame extends Node2D

signal won()
signal lost()

@export var difficulty = 1

@onready var label = $CanvasLayer/Control/Label
@onready var bar = $CanvasLayer/Control/ProgressBar
@onready var timer = $Timer

var score = 0.0

func _ready() -> void:
	label.text = name

func _process(_delta: float) -> void:
	bar.value = score

func _on_timer_timeout() -> void:
	_on_lost_game()

func _on_won_game() -> void:
	won.emit()

func _on_lost_game() -> void:
	lost.emit()