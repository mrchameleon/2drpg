extends CanvasLayer

signal shown
signal hidden

@onready var savebtn: Button = $Control/VBoxContainer/savebtn
@onready var loadbtn: Button = $Control/VBoxContainer/loadbtn
@onready var item_desc: Label = $Control/ItemDesc

var is_paused : bool = false


func _ready() -> void:
	if is_paused == false:
		visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause()
		else:
			hide_pause()
		get_viewport().set_input_as_handled()

func show_pause() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	shown.emit()
	
func hide_pause() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	hidden.emit()


func _on_savebtn_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	show_pause()
	


func _on_loadbtn_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	await GameManager.level_loaded
	hide_pause()


func update_item_description(new_text : String) -> void:
	item_desc.text = new_text
