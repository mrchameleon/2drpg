class_name Persist extends Node

signal data_loaded

var value : bool = false



func _ready() -> void:
	get_value()
	
	
func set_value() -> void:
	SaveManager.add_persist_value(_get_name())
	
func get_value() -> void:
	value = SaveManager.check_persist_value(_get_name())
	data_loaded.emit()
	
func _get_name() -> String:
	return get_tree().current_scene.scene_file_path + "/" + get_parent().name + "/" + name
