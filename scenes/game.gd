class_name Game extends Node2D

signal game_ended()

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
	start_game()
	
func start_game() -> void:
	if not _check_game_end():
		_next_game()

func _process(delta: float) -> void:
	if active_game != null:
		rope.value = Globals.current_side * active_game.score / float(Globals.MAX_MINI_GAME_SCORE)

func _next_game() -> void:
	game_index = (game_index + 1) % len(mini_games)
	active_game = mini_games[game_index].instantiate()
	active_game.difficulty = difficulty
	active_game.won.connect(_on_mini_game_won)
	active_game.lost.connect(_on_mini_game_lost)
	add_child(active_game)
	print("playing next mini-game: ", active_game.name)

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
	start_game()

func _check_game_end() -> bool:
	if abs(Globals.phase_score) >= Globals.MAX_WINS:
		game_ended.emit()
		return true
	return false
