extends Node

const TAGGER_META := "tagger"
const WON_PLAYER_TEXT := "Player %s Wins!"
const PLAYER_ONE_TEXT := "One"
const PLAYER_TWO_TEXT := "Two"

const RELOAD_CURRENT_SCENE := "reload_current_scene"

@export_group("Player Related")
@export var player_one : CharacterBody2D
@export var player_two : CharacterBody2D
@export var player_one_spawn : Marker2D
@export var player_two_spawn : Marker2D

@export_group("Game Logic")
@export var set_time : int
@export var game_timer : Timer
@export var game_time_label : Label
@export var pause_button : Button
@export var power_up_spawns : Node
@export var main_menu_button_canvas : CanvasLayer

@export_group("Play Again UI")
@export var play_again_control : Control
@export var player_won_label : Label


func _ready() -> void:
	get_tree().paused = true

 
func _process(_delta):
	if !get_tree().paused:
		game_time_label.text = str(int(ceil(game_timer.time_left)))


# starts the game picks a random player to be it and update indicator
func _start_game(time : int) -> void:
	Global.game_running = true
	game_timer.start(time)
	
	player_one.global_position = player_one_spawn.global_position
	player_two.global_position = player_two_spawn.global_position
	
	if randi() % 2 == 0:
		player_one.set_meta(TAGGER_META, true)
		player_two.set_meta(TAGGER_META, false)
	else:
		player_one.set_meta(TAGGER_META, false)
		player_two.set_meta(TAGGER_META, true)
	
	player_one.update_indicator()
	player_two.update_indicator()


# When the game is over clears power ups waits for powerups to clear then pausese the game
func _on_timer_timeout():
	player_one.clear_power_ups()
	player_two.clear_power_ups()
	await power_up_spawns.clear_powerups()
	get_tree().paused = true
	Global.game_running = false
	play_again_control.visible = true
	pause_button.visible = false
	var won_player : String
	
	# bassed on who is in at the end will show a different win text 
	if player_one.get_meta(TAGGER_META, false):
		won_player = PLAYER_TWO_TEXT
	else:
		won_player = PLAYER_ONE_TEXT
	
	player_won_label.text = WON_PLAYER_TEXT % won_player
 

# reloads the scene to go back to main menu
func _on_main_menu_button_pressed() -> void:
	get_tree().call_deferred(RELOAD_CURRENT_SCENE)
