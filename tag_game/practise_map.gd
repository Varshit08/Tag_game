extends StaticBody2D

@export var set_time : int
@export var timer : Timer
@export var label : Label


func _ready():
	timer.start(set_time)


func _process(_delta):
	if !get_tree().paused:
		label.text = str(int(ceil(timer.time_left)))
	
	
func _on_timer_timeout():
	label.text = "Time Is Up!"
	print("Time Is Up!")
	get_tree().paused = true
