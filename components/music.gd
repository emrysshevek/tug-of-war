extends Node


@onready var main = {
	"full": preload("res://assets/music/Main_Theme_Full.mp3"),
	"intro": preload("res://assets/music/Main_Theme_Intro.mp3"),
	"main": preload("res://assets/music/Main_Theme_MainPart.mp3"),
	"outro": preload("res://assets/music/Main_Theme_Outro.mp3"),
}
@onready var battle = {
	"full": preload("res://assets/music/Battle_Theme_Full.mp3"),
	"intro": preload("res://assets/music/Battle_Theme_IntroLoop.mp3"),
	"main": preload("res://assets/music/Battle_Theme_MainPart.mp3"),
	"outro": preload("res://assets/music/Battle_Theme_Outro.mp3"),
}
@onready var _anim_player: AnimationPlayer = $AnimationPlayer
@onready var _track_1: AudioStreamPlayer = $Track1
@onready var _track_2: AudioStreamPlayer = $Track2

func _ready() -> void:
	crossfade_to(main["intro"])

func crossfade_to(stream: AudioStream) -> void:
	print("Chaning background music to ", str(stream))

	# If both tracks are playing, we're calling the function in the middle of a fade.
	# We return early to avoid jumps in the sound.
	if _track_1.playing and _track_2.playing:
		return

	# The `playing` property of the stream players tells us which track is active. 
	# If it's track two, we fade to track one, and vice-versa.
	if _track_2.playing:
		_track_1.stream = stream
		_track_1.play()
		_anim_player.play("FadeToTrack1")
	else:
		_track_2.stream = stream
		_track_2.play()
		_anim_player.play("FadeToTrack2")