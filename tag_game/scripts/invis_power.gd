extends Area2D

const TAGGER_META := "tagger"

@export var marker : Marker2D
@export var spawner : Node

var picked_up := false


# makes the player invisible
func _on_body_entered(body: Node2D) -> void:
	if body.has_meta(TAGGER_META) and not picked_up:
		picked_up = true
		body.invis_boost_start()
		spawner.power_up_pickup(marker)
		queue_free()
