class_name State extends Node

static var player : Player
static var state_machine : PlayerStateMachine

func _ready():
	pass

func init() -> void:
	pass

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process( _delta: float ) -> State:
	return null

func physics( _delta: float ) -> State:
	return null
	
func handleInput(_event: InputEvent) -> State:
	return null
