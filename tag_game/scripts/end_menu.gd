extends Control

const MAX_TIME := 300
const MIN_TIME := 10
const TIME_STEP := 10

const TIME_FORMAT := "%dsec"
const PLAY_AGAIN_TEXT := "Play Again"

const END_OVERLAY_TRANSPARENT := Color(1.0, 1.0, 1.0, 0.435)

@export var scene_root : Node2D
@export var time_display : Label
@export var pause_button : Button

@export var play_again_button_lable : Label
@export var overlay : ColorRect


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	time_display.text = TIME_FORMAT % scene_root.set_time


func _on_play_again_button_pressed() -> void:
	pause_button.visible = true
	get_tree().paused = false
	visible = false
	scene_root._start_game(scene_root.set_time)
	play_again_button_lable.text = PLAY_AGAIN_TEXT 
	overlay.color = END_OVERLAY_TRANSPARENT


func _on_minus_time_pressed() -> void:
	if scene_root.set_time - TIME_STEP >= MIN_TIME:
		scene_root.set_time -= TIME_STEP
	
	time_display.text = TIME_FORMAT % scene_root.set_time


func _on_add_time_pressed() -> void:
	if scene_root.set_time + TIME_STEP <= MAX_TIME:
		scene_root.set_time += TIME_STEP
	
	time_display.text = TIME_FORMAT % scene_root.set_time
