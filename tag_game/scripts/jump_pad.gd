extends Area2D

const TAGGER_META := "tagger"

@export var boost_velocity: float = -800


# adds the boost velocity
func _on_body_entered(body: Node2D) -> void:
	if body.has_meta(TAGGER_META):
		body.velocity.y = boost_velocity
