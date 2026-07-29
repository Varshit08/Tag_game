extends Label


func _ready() -> void:
	show()


func _process(delta: float) -> void:
	if PractiseMap.paused == true:
		show()
	else:
		hide()
