class_name BarredDoor extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass
	
	
func open_door() -> void:
	anim.play("opening")
	
	
func close_door() -> void:
	anim.play("closing")
	
