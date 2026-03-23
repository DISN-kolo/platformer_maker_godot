extends Area2D;

@export var exit_id: int = 0;
@export var level_id_to_exit_to: int = 1;
@export var spawn_id_to_exit_to: int = 0;
var our_level: int = 0;

func _on_body_entered(body: Node2D) -> void:
	print(body);
	print(body.position);
	print(position);
	if (body.is_in_group("player")):
		print("sending signal of entry from ", self);
		Signals.goto_from.emit(
			our_level,
			exit_id,
			level_id_to_exit_to,
			spawn_id_to_exit_to
		);
