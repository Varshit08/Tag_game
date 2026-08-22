extends Area2D

const TAGGER_META := "tagger"

@export var boost_time : float = 2.5

var picked_up := false


func _on_body_entered(body: Node2D) -> void:
	if body.has_meta(TAGGER_META) and not picked_up:
		picked_up = true
		body.speed_boost_start()
		queue_free()
