class_name Statue extends RigidBody2D

@export var push_speed : float = 30.0

var push_dir : Vector2 = Vector2.ZERO : set = _set_push

@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _set_push(value: Vector2) -> void:
	push_dir = value
	if push_dir != Vector2.ZERO:
		sfx.play()
	else:
		sfx.stop()


func _physics_process(_delta: float) -> void:
	linear_velocity = push_dir * push_speed
