extends ColorRect



func _process(delta: float) -> void:
    var mat = material as ShaderMaterial
    mat.set_shader_parameter("amount", Globals.inversion_amount)
