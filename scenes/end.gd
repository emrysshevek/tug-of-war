extends Node2D

var backgrounds = {
	"light": preload("res://assets/sprites/ui/Ending_Light.png"),
	"dark": preload("res://assets/sprites/ui/Ending_Dark.png"),
	"both": preload("res://assets/sprites/ui/Ending_Both.png")
}

@onready var texture_rect: TextureRect = $CanvasLayer/Control/TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Globals.ending)
	texture_rect.texture = backgrounds[Globals.ending]

func _process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		get_tree().change_scene_to_file("res://scenes/title.tscn")
