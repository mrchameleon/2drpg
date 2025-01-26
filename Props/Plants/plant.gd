class_name Plant extends Node2D


func _ready() -> void:
	$Hitbox.Damaged.connect( TakeDamage )

func TakeDamage( _damage : int) -> void:
	# this "removes/cleans up the node"
	# a simple way to destroy the object/instance.
	queue_free()
