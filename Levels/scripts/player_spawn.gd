extends Node2D



func _ready() -> void:
	visible = false
	if PlayerManager.player_spawned == false:
		print("this code doesn't run for initial spawn... lol")
		# how can we allow to spawn on coords of a player spawn in the editor?
		PlayerManager.set_player_position( self.global_position )
		PlayerManager.player_spawned = true
