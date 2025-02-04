extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
	quests = [],
	spells_learned = []
}


func save_game() -> void:
	update_player_data()
	update_scene_path()
	var file := FileAccess.open(SAVE_PATH + "ponder.orb", FileAccess.WRITE)
	var save_json = JSON.stringify( current_save )
	file.store_line(save_json)
	game_saved.emit()
	print("game data was saved!")

	
func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "ponder.orb", FileAccess.READ)
	var json := JSON.new()
	json.parse( file.get_line() )
	
	var save_data := json.get_data() as Dictionary
	current_save = save_data

	GameManager.load_new_level(
		current_save.scene_path, "", Vector2.ZERO
	)
	await GameManager.level_load_started
	
	PlayerManager.set_player_position(
		Vector2(current_save.player.pos_x, current_save.player.pos_y)
	)
	PlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	
	await GameManager.level_loaded
	
	game_loaded.emit()
	print("saved game data loaded!")


func update_player_data() -> void:
	var p : Player = PlayerManager.player
	current_save.player.hp = p.hp
	current_save.player.max_hp = p.max_hp
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y


func update_scene_path() -> void:
	current_save.scene_path = get_tree().current_scene.scene_file_path
