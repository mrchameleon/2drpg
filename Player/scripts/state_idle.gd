class_name StateIdle extends State

@onready var walk: State = $"../Walk"

func enter() -> void:
	player.updateAnimation("idle")
	
func exit() -> void:
	pass
	
func process( _delta: float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

func physics( _delta: float ) -> State:
	return null
	
func handleInput(_event: InputEvent) -> State:
	return null
