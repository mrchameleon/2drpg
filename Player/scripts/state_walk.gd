class_name StateWalk extends State

@export var moveSpeed : float = 100.0

@onready var idle: StateIdle = $StateMachine/Idle

func enter() -> void:
	player.updateAnimation("walk")
	
func exit() -> void:
	pass
	
func process( _delta: float ) -> State:
	if player.direction == Vector2.ZERO:
		player.updateAnimation("idle")
	
	player.velocity = player.direction * moveSpeed
	
	if player.setDirection():
		player.updateAnimation("walk")
	
	return null

func physics( _delta: float ) -> State:
	return null
	
func handleInput(_event: InputEvent) -> State:
	return null
