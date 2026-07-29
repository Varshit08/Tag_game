extends CharacterBody2D

const TAGGER_META := "tagger"

var SPEED := 300.0
var JUMP_VELOCITY := -500.0

@export var player_texture : Texture
@export var tag_indicator : TextureRect
@export var can_tag : bool = true

@export_group("Player Changes")
@export var jump : String
@export var left : String
@export var right : String
@export var texture_rect : TextureRect


func _ready() -> void:
	texture_rect.texture = player_texture
	update_indicator()
	print(get_meta(TAGGER_META))


func _physics_process(delta: float) -> void:
	if PractiseMap.paused == false:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed(jump) and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis(left, right)
		
		if direction != 0:
				texture_rect.flip_h = direction < 0
		
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		move_and_slide()
		if get_meta(TAGGER_META, true):
			SPEED = 310.0
		else:
			SPEED = 300.0

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
