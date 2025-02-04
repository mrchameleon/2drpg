extends CanvasLayer

@onready var loadbtn: Button = $ColorRect/VBoxContainer/loadbtn
@onready var savebtn: Button = $ColorRect/VBoxContainer/savebtn

var is_paused : bool = false


func _ready() -> void:
	pass

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
	savebtn.grab_focus()
	
func hide_pause() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false


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
