class_name Plant extends Node2D


func _ready() -> void:
	$Hitbox.damaged.connect(take_damage)

func take_damage(_damage : Hurtbox) -> void:
	# this "removes/cleans up the node"
	# a simple way to destroy the object/instance.
	queue_free()
