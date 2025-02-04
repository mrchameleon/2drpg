extends Node

const PLAYER = preload("res://Player/player.tscn")

var player : Player
var player_spawned : bool = false


func _ready() -> void:
	add_player_instance()
	player_spawned = true


func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child( player )

func set_health(hp, max_hp) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.update_hp(0)

func set_player_position(_new_pos: Vector2) -> void:
	player.global_position = _new_pos

func set_as_parent(_p: Node2D) -> void:
	# re-parent player to current scene/parent node
	# to prevent 'wrong layer' issues
	player_spawned = false
	if player.get_parent():
		# remove from old parent if necessary
		player.get_parent().remove_child( player )
	_p.add_child(player)
	player_spawned = true

func unparent_player(_p: Node2D) -> void:
	_p.remove_child(player)
