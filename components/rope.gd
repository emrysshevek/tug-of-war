class_name Rope extends Node2D

@export var value := 0.0
@export var padding := 0.0

@onready var starting_pos := position.x


func _process(delta: float) -> void:
	var screen_width = get_viewport().get_visible_rect().size.x
	var width = (screen_width / 2) - padding
	position.x =  starting_pos + (width * value)


func _on_heart_area_area_entered(area:Area2D) -> void:
	print("heart area area entered")
	Globals.on_heart_hit()


func _on_heart_area_body_entered(body:Node2D) -> void:
	print("heart area body entered")
	Globals.on_heart_hit()