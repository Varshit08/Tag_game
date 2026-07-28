extends StaticBody2D

const TAGGER_META := "tagger"


@export var set_time : int
@export var timer : Timer
@export var label : Label
@export var player_one : CharacterBody2D
@export var player_two : CharacterBody2D
@export var winner_label : Label


func _ready():
	randomize()
	timer.start(set_time)
	
	if randi() % 2 == 0:
		player_one.set_meta(TAGGER_META, true)
		player_two.set_meta(TAGGER_META, false)
		print("Set player one meta")
	else:
		player_one.set_meta(TAGGER_META, false)
		player_two.set_meta(TAGGER_META, true)
		print("Set player two meta")
	
	player_one.update_indicator()
	player_two.update_indicator()


func _process(_delta):
	if !get_tree().paused:
		label.text = str(int(ceil(timer.time_left)))



func _on_timer_timeout():
	print("Time Is Up!")
	
	if player_one.get_meta(TAGGER_META, false):
		label.text = "Time Is Up!
		 Player One Loses!"
		print("Player One Loses!")
	elif player_two.get_meta(TAGGER_META, false):
		label.text = "Time Is Up!
		Player Two Loses!"
		print("Player Two Loses!")
		
	get_tree().paused = true
