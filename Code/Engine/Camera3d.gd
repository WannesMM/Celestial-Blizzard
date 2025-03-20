extends Node3D  # Attach this to a Node3D (should be the camera holder or player root)

@export var rotation_speed: float = 0.0025  # Mouse sensitivity
@export var max_yaw: float = deg_to_rad(55)  # Horizontal limit (left/right)
@export var max_pitch: float = deg_to_rad(60)  # Vertical limit (up/down)
@export var min_pitch: float = deg_to_rad(15)  # Vertical limit (up/down)
@export var smoothing: float = 1.5  # Higher = slower but smoother

var yaw: float = 0.0  # Target horizontal rotation
var pitch: float = 0.0  # Target vertical rotation

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * rotation_speed  # Horizontal rotation
		pitch -= event.relative.y * rotation_speed  # Vertical rotation (inverted)

		yaw = clamp(yaw, -max_yaw, max_yaw)  # Clamp horizontal rotation
		pitch = clamp(pitch, -min_pitch, max_pitch)  # Clamp vertical rotation

func _process(delta: float) -> void:
	# Smoothly interpolate to target yaw & pitch
	rotation.y = lerp(rotation.y, yaw, 1.0 - exp(-smoothing * delta))
	rotation.x = lerp(rotation.x, pitch, 1.0 - exp(-smoothing * delta))
