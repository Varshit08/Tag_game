extends Node

const TAGGER_META := "tagger"
const LOST_LABEL := "Time Is Up! /n Player %s Loses!"
const PLAYER_ONE_TEXT := "One"
const PLAYER_TWO_TEXT := "Two"

@export var set_time : int
@export var game_timer : Timer
@export var label : Label
@export var player_one : CharacterBody2D
@export var player_two : CharacterBody2D


func _ready():
	randomize()
	game_timer.start(set_time)
	
	if randi() % 2 == 0:
		player_one.set_meta(TAGGER_META, true)
		player_two.set_meta(TAGGER_META, false)
	else:
		player_one.set_meta(TAGGER_META, false)
		player_two.set_meta(TAGGER_META, true)
	
	player_one.update_indicator()
	player_two.update_indicator()


func _process(_delta):
	if !get_tree().paused:
		label.text = str(int(ceil(game_timer.time_left)))


func _on_timer_timeout():
	var lost_player : String
	
	if player_one.get_meta(TAGGER_META, false):
		lost_player  = PLAYER_ONE_TEXT
	else:
		lost_player  = PLAYER_TWO_TEXT
	
	get_tree().paused = true
