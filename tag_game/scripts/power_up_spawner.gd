extends Node

@export var spawner_timer : Timer
@export var spawn_node : Node
@export var power_ups : Array[PackedScene]

@export var spawn_interval := 10
## The probablity of a spawn spawning every spawn_interal seconds 0.3 = 30%
@export_range(0, 1, 0.01) var spawn_chance := 0.3

var spawn_markers : Dictionary


func _ready() -> void:
	# gets all the marker nodes and sets if they have a power up to false
	for marker in spawn_node.get_children():
		spawn_markers[marker] = false
	
	# started the spawning process
	spawner_timer.wait_time = spawn_interval
	spawner_timer.start()


func spawn_powerup() -> void:
	# probablity of successful spawn 
	if randf() > spawn_chance:
		return
	
	# gets all the valid markers with out a current powerup
	var valid_spawns : Array
	for marker in spawn_markers:
		if not spawn_markers[marker]:
			valid_spawns.append(marker)
	
	if not valid_spawns:
		return
	
	# chooses a random marker and powerup sets the power up marker and spawner for 
	# powerup removal
	var spawn_marker = valid_spawns.pick_random()
	var powerup = power_ups.pick_random().instantiate()
	
	powerup.global_position = spawn_marker.global_position
	spawn_markers[spawn_marker] = true
	powerup.marker = spawn_marker
	powerup.spawner = self
	add_child(powerup)


# spawns the power up on timeout
func _on_power_up_timer_timeout() -> void:
	spawn_powerup()


# sets the spawn marker to not have a powerup
func power_up_pickup(marker : Marker2D) -> void:
	spawn_markers[marker] = false
	
