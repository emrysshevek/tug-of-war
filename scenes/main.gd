class_name Main extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_introduction_ended)
	Dialogic.start("Introduction")

func _on_introduction_ended() -> void:
	var game = preload("res://scenes/game.tscn").instantiate()
	add_child(game)

	Dialogic.timeline_ended.disconnect(_on_introduction_ended)
	Dialogic.timeline_ended.connect(_on_phase1_ended)
	Dialogic.start("Phase1")

func _on_phase1_ended() -> void:
	Dialogic.timeline_ended.disconnect(_on_phase1_ended)
