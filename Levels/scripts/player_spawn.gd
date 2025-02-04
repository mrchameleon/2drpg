extends Node2D



func _ready() -> void:
	visible = false
	# allow to spawn on coords of a player spawn in the editor.
	PlayerManager.set_player_position( self.global_position )
	if PlayerManager.player_spawned == false:
		# we haven't spawned yet...
		# set spawn location at this instance's global_position
		PlayerManager.set_player_position( self.global_position )
		PlayerManager.player_spawned = true
