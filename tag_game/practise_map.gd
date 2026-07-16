extends StaticBody2D

@onready var timer = $Timer
@onready var label = $ColorRect/Label

func _ready():
	timer.start(120)

func _process(delta):
	if !get_tree().paused:
		label.text = str(int(timer.time_left))
	
func _on_timer_timeout():
	label.text = "Time Is Up!"
	print("Time Is Up!")
	get_tree().paused = true
