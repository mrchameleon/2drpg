extends CanvasLayer

var hearts : Array[ HeartGUI ] = []
@onready var hp_container: HFlowContainer = $Control/hp_container

func _ready() -> void:
	for child in hp_container.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false

func update_hp( _hp, _max_hp ) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i, _hp)


func update_heart(_index : int, _hp : int) -> void:
	var _value : int = clamp( _hp - _index * 2, 0, 2)
	hearts[_index].value = _value
	
func update_max_hp(_max_hp : int) -> void:
	var _heart_count : int = round(_max_hp / 2)
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
