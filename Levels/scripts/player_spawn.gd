extends Node2D



func _ready() -> void:
	visible = false
	if PlayerManager.player_spawned == false:
		# haven't spawned yet...
		# set spawn location at this instance's global_position
		PlayerManager.set_player_position( global_position )
		PlayerManager.player_spawned = true
