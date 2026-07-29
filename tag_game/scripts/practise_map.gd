extends StaticBody2D

const TAGGER_META := "tagger"


@export var set_time : int
@export var timer : Timer
@export var label : Label
@export var player_one : CharacterBody2D
@export var player_two : CharacterBody2D
@export var winner_label : Label
@export var paused = false


func _ready():
	randomize()
	timer = get_tree().current_scene.get_node("Timer")
	player_one = get_tree().current_scene.get_node("playerone")
	player_two = get_tree().current_scene.get_node("playertwo")
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
	if paused == false:
		label = get_tree().current_scene.get_node("CanvasLayer/Label")
		label.text = str(int(ceil(timer.time_left)))
	
	if Input.is_action_just_released("pause"):
		if paused == false:
			paused = true
			print("paused")
			return
		if paused == true:
			paused = false
			print("unpaused")
			return



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
