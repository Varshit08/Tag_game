class_name player
extends CharacterBody2D

const TAGGER_META := "tagger"
const WALK_RIGHT_OFFSET := Vector2(-5.0, -9.0)
const WALK_LEFT_OFFSET := Vector2(1.0, -9.0)
const PLAYER_TEXTURE_OFFSET_LOOKUP := {
	-1 : WALK_LEFT_OFFSET,
	1 : WALK_RIGHT_OFFSET
}

const WALK_RIGHT := "walk_right"
const WALK_LEFT := "walk_left"

const NORMAL_SPEED := 300.0
const TAG_SPEED := 310.0
const JUMP_VELOCITY := -500.0

# Power Ups
# Speed multipul
const SPEED_POWER_BOOST := 1.3
const SPEED_POWER_TIME := 5

# Jump Height Additive
const JUMP_POWER_BOOST := -150
const JUMP_POWER_TIME := 5

# Invis Powerup
const INVIS_MODULATE := Color(1.0, 1.0, 1.0, 0.400)
const NORMAL_MODULATE := Color(1, 1, 1, 1)
const INVIS_TIME := 5

@export var player_texture : Texture
@export var tag_indicator : TextureRect
@export var can_tag : bool = true
@export var animation_player : AnimationPlayer
@export var collision_shape : CollisionShape2D

@export_group("Power Up Timers")
@export var speed_timer : Timer
@export var jump_timer : Timer
@export var invis_timer : Timer

@export_group("Player Changes")
@export var jump : String
@export var left : String
@export var right : String
@export var player_texture_rect : TextureRect

var speed_boost_active := false
var jump_boost_active := false
var invis_boost_active := false
var speed = NORMAL_SPEED


func _ready() -> void:
	player_texture_rect.texture = player_texture
	update_indicator()


func _physics_process(delta: float) -> void:
	# Add the gravity.x
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY + min(JUMP_POWER_BOOST * int(jump_boost_active), 0)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(left, right)
	if direction != 0:
			player_texture_rect.flip_h = direction < 0
			player_texture_rect.position = PLAYER_TEXTURE_OFFSET_LOOKUP[int(direction)]
			
			if not animation_player.is_playing():
				if direction < 0:
					animation_player.play(WALK_LEFT)
				else:
					animation_player.play(WALK_RIGHT)
			
	else:
		animation_player.stop()
	
	if direction:
		velocity.x = direction * speed * max(SPEED_POWER_BOOST * int(speed_boost_active), 1)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	if get_meta(TAGGER_META, true):
		speed = TAG_SPEED
	else:
		speed = NORMAL_SPEED


func update_indicator():
	tag_indicator.visible = get_meta(TAGGER_META)


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body == self:
		return
	if !can_tag:
		return
	
	if get_meta(TAGGER_META, false):
			
		set_meta(TAGGER_META, false)
		body.set_meta(TAGGER_META, true)
		
		update_indicator()
		body.update_indicator()
		can_tag = false
		body.can_tag = false


func reset_can_tag():
	can_tag = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	can_tag = true
	body.reset_can_tag()


# Power ups ------------------------------------------------------------------
func speed_boost_start() -> void:
	speed_boost_active = true
	
	speed_timer.start(SPEED_POWER_TIME)


func _on_speed_boost_timer_timeout() -> void:
	speed_boost_active = false


func jump_boost_start() -> void:
	jump_boost_active = true
	
	jump_timer.start(JUMP_POWER_TIME)


func _on_jump_boost_timer_timeout() -> void:
	jump_boost_active = false


func invis_boost_start() -> void:
	invis_boost_active = true
	modulate = INVIS_MODULATE
	
	invis_timer.start(INVIS_TIME)


func _on_invis_boost_timer_timeout() -> void:
	invis_boost_active = true
	modulate = NORMAL_MODULATE


func clear_power_ups() -> void:
	_on_speed_boost_timer_timeout()
	_on_invis_boost_timer_timeout()
	_on_invis_boost_timer_timeout()
	jump_timer.stop()
	speed_timer.stop()
	invis_timer.stop()
