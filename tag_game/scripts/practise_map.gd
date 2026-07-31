extends Node

const TAGGER_META := "tagger"

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
	
	if player_one.get_meta(TAGGER_META, false):
		label.text = "Time Is Up!
		 Player One Loses!"
	elif player_two.get_meta(TAGGER_META, false):
		label.text = "Time Is Up!
		Player Two Loses!"
	
	get_tree().paused = true


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	# Replace with function body.
