class_name Game extends Node2D

@export var difficulty = 1
@export var active_game: MiniGame = null

@onready var mini_games: Array[PackedScene] = [
	preload("res://scenes/mini_games/hold.tscn"),
	preload("res://scenes/mini_games/dodge.tscn"),
	preload("res://scenes/mini_games/react.tscn"),
	preload("res://scenes/mini_games/time.tscn"),
	preload("res://scenes/mini_games/mash.tscn")
]
@onready var rope: Rope = $Rope

var game_index := -1

func _ready() -> void:
	Dialogic.timeline_ended.connect(start_game)
	Dialogic.signal_event.connect(_on_dialogue_signal)

func start_game() -> void:
	if Dialogic.timeline_ended.is_connected(start_game):
		Dialogic.timeline_ended.disconnect(start_game)
	if not _check_game_end():
		_next_game()

func _process(delta: float) -> void:
	if active_game != null:
		rope.value = Globals.current_side * active_game.score / Globals.MAX_MINI_GAME_SCORE

func _next_game() -> void:
	game_index = (game_index + 1) % len(mini_games)
	active_game = mini_games[game_index].instantiate()
	active_game.difficulty = difficulty
	active_game.won.connect(_on_mini_game_won)
	active_game.lost.connect(_on_mini_game_lost)
	add_child(active_game)

func _on_mini_game_won() -> void:
	print("mini game won: ", active_game.name)
	Globals.update_from_winner(Globals.current_side)
	_on_mini_game_end("light" if Globals.current_side == -1 else "dark")

func _on_mini_game_lost() -> void:
	print("mini game lost: ", active_game.name)
	Globals.update_from_winner(-Globals.current_side)
	_on_mini_game_end("light" if Globals.current_side == 1 else "dark")

func _on_mini_game_end(winner: String) -> void:
	if active_game != null and is_instance_valid(active_game):
		active_game.queue_free()

	Dialogic.VAR.state.last_winner = winner
	if Dialogic.current_timeline == null:
		Interjections.play_interjection()
	Dialogic.timeline_ended.connect(start_game)

func _check_game_end() -> bool:
	if abs(Globals.score) >= Globals.MAX_WINS:
		active_game.queue_free()
		add_child(preload("res://scenes/win_screen.tscn").instantiate())
		return true
	return false

func _on_dialogue_signal(arg: Dictionary) -> void:
	if arg.type == "side":
		Globals.current_side = arg.value
		print("new side is ", Globals.current_side)
