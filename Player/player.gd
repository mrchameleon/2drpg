extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var speed : float = 100.0
var state : String = "idle"

# NOTE: variables up here will be available on the player for other scripts to use

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = direction * speed

	if updateState() == true || setDir() == true:
		updateAnim()

func _physics_process(delta: float) -> void:
	move_and_slide()

func setDir() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if new_dir == Vector2.ZERO:
		return false
	#print('y: ' + str(direction.y))
	#print('x: ' + str(direction.x))
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN

	if new_dir == cardinal_direction:
		return false

	cardinal_direction = new_dir
	
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1

	return true
	
func updateState() -> bool:
	var new_state = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false

	state = new_state

	return true

func translateDir():
	if cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.DOWN:
		return "down"
	else:
		print("cardinal_direction: " + str(cardinal_direction))
		return "side"

func updateAnim() -> void:	
	animation_player.play(state + '_' + translateDir())
