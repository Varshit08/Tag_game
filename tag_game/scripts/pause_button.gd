extends Button

const PAUSE_BUTTON := preload("res://assets/button_assets/pausebutton.png")
const PLAY_BUTTON := preload("res://assets/button_assets/playbutton.png")
const PAUSE_INPUT := "pause"
const PAUSE_BUFFER := 0.1

@export var pause_menu : Control

var pause_debounce := false


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(PAUSE_INPUT):
		_toggle_pause()


func _on_pressed() -> void:
	_toggle_pause()


func _toggle_pause() -> void:
	if pause_debounce or not Global.game_running:
		return
	
	pause_debounce = true
	
	Global.game_paused = not Global.game_paused
	get_tree().paused = Global.game_paused
	pause_menu.visible = Global.game_paused
	
	if Global.game_paused:
		icon = PLAY_BUTTON
	else:
		icon = PAUSE_BUTTON
	
	await get_tree().create_timer(PAUSE_BUFFER).timeout
	pause_debounce = false
