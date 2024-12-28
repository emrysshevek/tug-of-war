class_name Game extends Node2D

@export var difficulty = 1
@export var active_game: MiniGame = null

@onready var mini_games: Array[PackedScene] = [
	preload("res://scenes/mini_games/time.tscn"),
	preload("res://scenes/mini_games/hold.tscn"),
	preload("res://scenes/mini_games/mash.tscn")
]
@onready var rope: Rope = $Foreground/Control/Rope

var game_index := -1

func _ready() -> void:
	_next_game()

func _process(delta: float) -> void:
	rope.value = active_game.score / Globals.MAX_MINI_GAME_SCORE

func _next_game() -> void:
	if active_game != null:
		active_game.queue_free()

	game_index = (game_index + 1) % len(mini_games)
	active_game = mini_games[game_index].instantiate()
	active_game.difficulty = difficulty
	active_game.won.connect(_on_mini_game_won)
	active_game.lost.connect(_on_mini_game_lost)
	add_child(active_game)

func _on_mini_game_won() -> void:
	print("mini game won: ", active_game.name)
	difficulty += 1
	Globals.wins += 1
	if not _check_game_end():
		_next_game()

func _on_mini_game_lost() -> void:
	print("mini game lost: ", active_game.name)
	Globals.losses += 1
	if not _check_game_end():
		_next_game()

func _check_game_end() -> bool:
	if Globals.wins >= Globals.MAX_WINS:
		active_game.queue_free()
		add_child(preload("res://scenes/win_screen.tscn").instantiate())
		return true
	elif Globals.losses >= Globals.MAX_LOSSES:
		active_game.queue_free()
		add_child(preload("res://scenes/lose_screen.tscn").instantiate())
		return true
	return false
