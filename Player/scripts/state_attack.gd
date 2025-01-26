class_name StateAttack extends State

@onready var animation_player: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var sword_anim: AnimationPlayer = $"../../Sprite2D/SwordEffect/SwordAnim"

@onready var walk: StateWalk = $"../Walk"
@onready var idle: StateIdle = $"../Idle"
@onready var hurtbox: Hurtbox = $"../../Sprite2D/AttackHurtbox"

var attacking: bool = false

@onready var player_audio: AudioStreamPlayer2D = $"../../Audio/PlayerAudio"
@export var attack_sound =  AudioStream 
@export_range(1,20,0.5) var decelerate_speed : float = 5.0



func enter() -> void:
	player.updateAnimation("attack")
	sword_anim.play("attack_" + player.animationDirection())
	animation_player.animation_finished.connect(endAttack)
	player_audio.stream = attack_sound
	player_audio.pitch_scale = randf_range(0.85, 1.15)
	player_audio.play()
	
	attacking = true
	await get_tree().create_timer(0.075).timeout
	hurtbox.monitoring = true
	
func exit() -> void:
	animation_player.animation_finished.disconnect(endAttack)
	attacking = false
	hurtbox.monitoring = false

func process(delta: float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func physics( _delta: float ) -> State:
	return null
	
func handleInput(_event: InputEvent) -> State:
	return null

func endAttack(_newAnimName: String) -> void:
	attacking = false
