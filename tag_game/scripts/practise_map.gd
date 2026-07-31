extends Node2D

const TAGGER_META := "tagger"

@export var set_time : int
@export var game_timer : Timer
@export var timer_label : Label
@export var player_one : CharacterBody2D
@export var player_two : CharacterBody2D
@export var paused = false


func _ready():
	if game_timer == null:
		push_error("game_timer is NULL!")
		return

	game_timer.start(set_time)


func _process(_delta):
	if game_timer == null:
		return

	timer_label.text = str(int(ceil(game_timer.time_left)))


func _on_timer_timeout():
	print("Time Is Up!")
	
	if player_one.get_meta(TAGGER_META, false):
		timer_label.text = "Time Is Up!\nPlayer One Loses!"
		print("Player One Loses!")
	elif player_two.get_meta(TAGGER_META, false):
		timer_label.text = "Time Is Up!\nPlayer Two Loses!"
		print("Player Two Loses!")
		
	get_tree().paused = true
