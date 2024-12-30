class_name Main extends Node2D

var phase_timelines := [
	"Phase1",
	"Phase2",
	"Phase3",
]

var game: Game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_introduction_ended)
	Dialogic.start_timeline("Introduction")

func _on_introduction_ended() -> void:
	Dialogic.timeline_ended.disconnect(_on_introduction_ended)
	Dialogic.timeline_ended.connect(_on_phase_ended)
	_start_next_phase()

func _on_phase_ended() -> void:
	_start_game()

func _start_next_phase() -> void:
	Dialogic.start(phase_timelines[Globals.phase])

func _start_game() -> void:
	if is_instance_valid(game):
		game.queue_free()
		
	game = preload("res://scenes/game.tscn").instantiate()
	game.game_ended.connect(_on_game_ended)
	add_child(game)

func _on_game_ended() -> void:
	game.queue_free()
	Globals.phase += 1

	if Globals.phase < len(phase_timelines):
		_start_next_phase()
	else:
		Dialogic.timeline_ended.disconnect(_on_phase_ended)
		Dialogic.timeline_ended.connect(_on_resolution_ended)
		Dialogic.start_timeline("Resolution")

func _on_resolution_ended() -> void:
	print("The end :)")
