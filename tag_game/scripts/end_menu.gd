extends Control

const MAX_TIME := 300
const MIN_TIME := 10
const TIME_STEP := 10

const TIME_FORMAT := "%dsec"

@export var scene_root : Node2D
@export var time_display : Label
@export var pause_button : Button

@onready var selected_time : int = scene_root.set_time


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	time_display.text = TIME_FORMAT % selected_time


func _on_play_again_button_pressed() -> void:
	pause_button.visible = true
	get_tree().paused = false
	visible = false
	scene_root._start_game(selected_time)


func _on_minus_time_pressed() -> void:
	if selected_time - TIME_STEP <= MIN_TIME:
		selected_time -= TIME_STEP
	
	time_display.text = TIME_FORMAT % selected_time


func _on_add_time_pressed() -> void:
	if selected_time + TIME_STEP <= MAX_TIME:
		selected_time += TIME_STEP
	
	time_display.text = TIME_FORMAT % selected_time
