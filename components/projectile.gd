class_name Projectile
extends RigidBody2D

func _ready() -> void:
	if Globals.current_side == -1:
		$Sprite2D.modulate = Color.BLACK

func update_scale(new_scale: Vector2) -> void:
	$CollisionShape2D.scale = new_scale
	$Sprite2D.scale = new_scale
	$CPUParticles2D.scale = new_scale

