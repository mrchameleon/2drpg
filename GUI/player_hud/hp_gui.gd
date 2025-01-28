class_name HeartGUI extends Control

@onready var heart_sprite: Sprite2D = $heart_sprite

var value : int = 2 :
	set(_value):
		value = _value
		update_sprite()


func update_sprite() -> void:
	heart_sprite.frame = value
