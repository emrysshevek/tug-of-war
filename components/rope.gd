class_name Rope extends TextureRect


@export var value := 0.0
@export var padding := 0.0


func _process(delta: float) -> void:
	var parent = get_parent_control()
	var parent_center = (parent.size.x / 2)
	var center = (size.x) / 2
	var width = (parent.size.x / 2) - padding
	position.x = parent_center + (width * value) - center


