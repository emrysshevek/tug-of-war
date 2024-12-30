class_name Main extends Node2D

var phase_timelines := [
	"Phase1",
	"Phase2",
	"Phase3",
]

var game: Game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Dialogic.Inputs.auto_skip.enabled = true
	# Dialogic.Inputs.auto_skip.disable_on_user_input = false
	# Dialogic.Inputs.auto_skip.disable_on_unread_text = false
	# Dialogic.Inputs.auto_skip.toggled.connect(_reenable_auto_skip)

	Music.crossfade_to(Music.main["main"])

	Dialogic.timeline_ended.connect(_on_introduction_ended)
	Dialogic.signal_event.connect(_on_dialogue_signal)
	Dialogic.start_timeline("Introduction")

# func _reenable_auto_skip(_is_enabled: bool) -> void:
# 	Dialogic.Inputs.auto_skip.enabled = true

func _on_introduction_ended() -> void:
	print("Introduction dialogue ended")
	Dialogic.timeline_ended.disconnect(_on_introduction_ended)
	Dialogic.timeline_ended.connect(_on_phase_ended)
	_start_next_phase()

func _on_phase_ended() -> void:
	print("phase dialogue ended")
	_start_game()

func _start_next_phase() -> void:
	print("starting new phase: ", phase_timelines[Globals.phase])
	Dialogic.start(phase_timelines[Globals.phase])
	Music.crossfade_to(Music.battle["intro"])
	$Background.show()
	$Background/Heart.show()

func _start_game() -> void:
	Music.crossfade_to(Music.battle["main"])
	$Background.hide()
	$Background/Heart.hide()
	print("Starting new battle")
	if is_instance_valid(game):
		game.queue_free()
		
	game = preload("res://scenes/game.tscn").instantiate()
	game.game_ended.connect(_on_game_ended)
	add_child(game)

func _on_game_ended() -> void:
	print("Battle ended")
	game.queue_free()
	Globals.phase += 1
	Globals.required_wins += 5

	if Globals.phase < len(phase_timelines):
		_start_next_phase()
	else:
		Dialogic.timeline_ended.disconnect(_on_phase_ended)
		Dialogic.timeline_ended.connect(_on_resolution_ended)
		Dialogic.start_timeline("Resolution")
		Music.crossfade_to(Music.main["full"])

func _on_resolution_ended() -> void:
	print("The end :)")
	get_tree().change_scene_to_file("res://scenes/end.tscn")

func _on_dialogue_signal(arg: Dictionary) -> void:
	print("received dialogue signal: ", arg)
	if arg.type == "side":
		Globals.current_side = arg.value
		print("new side is ", Globals.current_side)
	elif arg.type == "ending":
		Globals.ending = arg.value		

