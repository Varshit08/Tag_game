extends Node

const TAGGER_META := "tagger"
const WON_PLAYER_TEXT := "Player %s Wins!"
const PLAYER_ONE_TEXT := "One"
const PLAYER_TWO_TEXT := "Two"

@export_group("Player Related")
@export var player_one : CharacterBody2D
@export var player_two : CharacterBody2D
@export var player_one_spawn : Marker2D
@export var player_two_spawn : Marker2D

@export_group("Game Logic")
@export var set_time : int
@export var game_timer : Timer
@export var game_time_label : Label

@export_group("Play Again UI")
@export var play_again_control : Control
@export var player_won_label : Label


func _ready():
	_start_game(set_time)

 
func _process(_delta):
	if !get_tree().paused:
		game_time_label.text = str(int(ceil(game_timer.time_left)))


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


func _on_timer_timeout():
	get_tree().paused = true
	Global.game_running = false
	play_again_control.visible = true
	var won_player : String
	
	if player_one.get_meta(TAGGER_META, false):
		won_player = PLAYER_TWO_TEXT
	else:
		won_player = PLAYER_ONE_TEXT
	
	player_won_label.text = WON_PLAYER_TEXT % won_player
