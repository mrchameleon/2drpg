class_name Player extends CharacterBody2D

signal direction_changed( new_direction: Vector2 )
signal player_damaged ( hurtbox: Hurtbox )

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

var invulnerable : bool = false
@export var hp : int = 6
@export var max_hp : int = 6




# NOTE: variables up here will be available on the player for other scripts to use
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var animation_player_effect: AnimationPlayer = $AnimationPlayerEffect

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hitbox: Hitbox = $Hitbox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self
	state_machine.init(self)
	hitbox.damaged.connect( _take_damage )
	update_hp(99)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((direction+cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[direction_id]

	if new_dir == cardinal_direction:
		return false

	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation( state : String) -> void:
	animation_player.play( state + "_" + animation_direction() )

func animation_direction():
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage( hurtbox: Hurtbox ) -> void:
	if invulnerable == true:
		return
	update_hp( -hurtbox.damage )
	if hp > 0:
		player_damaged.emit( hurtbox )
	else:
		player_damaged.emit( hurtbox )
		update_hp(99) # immortality for now...
	
func update_hp( delta : int ) -> void:
	# limit any increases/decreases between 0 to max_hp
	hp = clampi( hp + delta, 0, max_hp )
	# update hp_gui (heart containers)
	PlayerHud.update_hp(hp, max_hp)
	
	
func make_invulnerable( _duration : float = 1.0 ) -> void:
	invulnerable = true
	hitbox.monitoring = false
	await get_tree().create_timer( _duration ).timeout
	invulnerable = false
	hitbox.monitoring = true
