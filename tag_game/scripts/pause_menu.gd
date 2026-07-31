extends Control

var paused := false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_pause_button_pressed() -> void:
	paused = not paused
	print("paused is now - ", paused)
	get_tree().paused = paused
	visible = paused
