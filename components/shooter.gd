class_name Shooter extends Node2D

signal shot(projectile: RigidBody2D)

@export var scene: PackedScene
@export var direction: Vector2
@export var spray: float
@export var min_delay: float
@export var max_delay: float
@export var auto_shoot: bool = true

@onready var timer = $Timer

func _ready() -> void:
	if auto_shoot:
		timer.wait_time = randf_range(min_delay, max_delay)
		timer.start()

func shoot(dir := Vector2.INF) -> void:
	print("shooting projectile")
	if dir == Vector2.INF:
		dir = direction
	
	var projectile: RigidBody2D = scene.instantiate()
	add_child(projectile)
	projectile.apply_force(dir.normalized() * 25)


func _on_timer_timeout() -> void:
	shoot()
	timer.wait_time = randf_range(min_delay, max_delay)
	timer.start()
