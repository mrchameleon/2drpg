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

# serialize the inventory state
func get_item_data() -> Array:
	var items : Array = []
	for i in slots.size():
		var dict_item = item_to_save(slots[i])
		items.append(dict_item)
	return items

# convert each inventory item into a dict to store in array above
func item_to_save(slot: SlotData) -> Dictionary:
	var result = {
		item = "",
		quantity = 0
	}
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
	return result

# parse items save_data for loading game save prev. inventory
func parse_items_save_data(save_data: Array) -> void:
	var array_size = slots.size()
	slots.clear() # clear existing
	slots.resize(array_size) # refill with 10 empty slots
	for i in save_data.size():
		slots[i] = item_from_save(save_data[i])
	connect_slots()

# return a SlotData obj from a single item dict
func item_from_save(save_object: Dictionary) -> SlotData:
	if save_object.item == "":
		return null
	var new_slot : SlotData = SlotData.new()
	new_slot.item_data = load(save_object.item)
	new_slot.quantity = int(save_object.quantity)
	return new_slot
