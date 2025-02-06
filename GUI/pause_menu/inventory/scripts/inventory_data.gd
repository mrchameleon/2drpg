class_name InventoryData extends Resource

@export var slots : Array[SlotData]

# note: for a Resource, _init() is similar to _ready()
func _init() -> void:
	connect_slots()


func add_item(item : ItemData, count : int = 1) -> bool:
	for s in slots:
		if s:
			# already have one of that item type, increase its quantity
			if s.item_data == item:
				s.quantity += count
				return true
	
	# add new item
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()       
			new.item_data = item
			new.quantity = count
			slots[i] = new
			new.changed.connect(slot_changed)
			return true                                                   
	
	# inventory is full
	return false


func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(slot_changed)


func slot_changed() -> void:
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(slot_changed)
				var index = slots.find(s)
				slots[index] = null
				emit_changed()
