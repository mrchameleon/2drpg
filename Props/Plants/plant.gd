class_name Plant extends Node2D

@onready var hitbox: Hitbox = $Hitbox

func _ready() -> void:
	hitbox.damaged.connect( take_damage )

func take_damage() -> void:
	# this "removes/cleans up the node"
	# a simple way to destroy the object/instance.
	queue_free()
