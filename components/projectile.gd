class_name Projectile
extends RigidBody2D

func update_scale(new_scale: Vector2) -> void:
	$CollisionShape2D.scale = new_scale
	$Sprite2D.scale = new_scale
	$CPUParticles2D.scale = new_scale

