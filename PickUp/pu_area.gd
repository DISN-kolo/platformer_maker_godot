extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player")):
		Signals.pickupable_picked_up.emit(
			get_node("..").pickup_id,
			get_node("..").global_position
		);
		get_node("..").queue_free();
