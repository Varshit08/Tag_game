extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var jump : String
@export var left : String
@export var right : String
@export var color : Color
@export var color_rect : ColorRect

@export var can_tag := true


func _ready() -> void:
	color_rect.color = color
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(left, right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	print(name, " - currently is : ", get_meta("tagger"))



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("tagger"):
		can_tag = false
		if body.get_meta("tagger") == true:
			set_meta("tagger", true)
			body.set_meta("tagger", false)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_meta("tagger"):
		can_tag = true
