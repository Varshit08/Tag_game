extends Camera2D

const MISSING_PLAYER_ASSIGNMENT := "players not assigned"

const MIN_X := -200.0
const MAX_X := 1950.0
const MAX_Y := 720.0

const MIN_ZOOM := 0.6
const MAX_ZOOM := 3.0
const PADDING := 300.0
const SMOOTH_SPEED := 5.0

@export var player1 : CharacterBody2D
@export var player2 : CharacterBody2D
@export var background : Sprite2D
@export var background_texture : Texture

var background_size : Vector2


func _ready() -> void:
	background.texture = background_texture
	background_size = background.texture.get_size()


func _process(delta: float) -> void:
	# Safety check
	if not player1 or not player2:
		push_error(MISSING_PLAYER_ASSIGNMENT)
		return
	
	# Viewport size
	var viewport_size := get_viewport_rect().size
	var viewport_x := viewport_size.x
	var viewport_y := viewport_size.y
	
	# Calculate zoom
	var player_dist := (player1.global_position - player2.global_position).abs()
	var required_x := (player_dist.x + PADDING) / viewport_x
	var required_y := (player_dist.y + PADDING) / viewport_y
	var required_ratio := maxf(required_x, required_y)
	
	var target_zoom_val := clampf(1.0 / required_ratio, MIN_ZOOM, MAX_ZOOM)
	var target_zoom := Vector2(target_zoom_val, target_zoom_val)
	
	zoom = zoom.lerp(target_zoom, SMOOTH_SPEED * delta)
	
	# Camera position
	var target_position := (player1.global_position + player2.global_position) / 2.0
	
	var half_width := (viewport_x / zoom.x) / 2.0
	var half_height := (viewport_y / zoom.y) / 2.0
	
	target_position.x = clampf(target_position.x, MIN_X + half_width, MAX_X - half_width)
	target_position.y = minf(target_position.y, MAX_Y - half_height)
	
	global_position = target_position
	
	var visible_size := viewport_size / zoom
	var scale_factor : float = max(
		visible_size.x / background_size.x,
		visible_size.y / background_size.y
	)
	
	background.scale = Vector2.ONE * scale_factor
