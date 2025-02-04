class_name PlayerCamera extends Node

var limit_left
var limit_top
var limit_right
var limit_bottom


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.tilemap_bounds_changed.connect( update_limits )
	update_limits( GameManager.current_tilemap_bounds )

func update_limits( bounds: Array[Vector2] ) -> void:
	if bounds == []:
		return
	limit_left = int( bounds[0].x )
	limit_top = int( bounds[0].y )
	limit_right = int( bounds[1].x )
	limit_bottom = int( bounds[1].y )
