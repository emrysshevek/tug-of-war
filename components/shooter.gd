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
		start_auto_shoot()

func start_auto_shoot() -> void:
	auto_shoot = true
	timer.wait_time = randf_range(min_delay, max_delay)
	timer.start()

func shoot(dir := Vector2.INF) -> void:
	if dir == Vector2.INF:
		dir = direction
	dir = dir.rotated(deg_to_rad(randf_range(-spray, spray)))

	var projectile: Projectile = scene.instantiate()
	var proj_scale = randf_range(.3, 1)
	projectile.update_scale(Vector2(proj_scale, proj_scale))
	add_child(projectile)
	projectile.apply_central_force(dir.normalized() * 20 * (1/proj_scale))


func _on_timer_timeout() -> void:
	shoot()
	timer.wait_time = randf_range(min_delay, max_delay)
	timer.start()
