extends Button

const PAUSE_BUTTON := preload("res://assets/button_assets/pausebutton.png")
const PLAY_BUTTON := preload("res://assets/button_assets/playbutton.png")
const PAUSE_INPUT := "pause"

@export var pause_menu : Control

var paused := false


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(PAUSE_INPUT):
		_on_pressed()


func _on_pressed() -> void:
	paused = not paused
	get_tree().paused = paused
	pause_menu.visible = paused
	
	if paused:
		icon = PLAY_BUTTON
	else:
		icon = PAUSE_BUTTON
