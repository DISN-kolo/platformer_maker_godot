extends Node;

func _ready() -> void:
	Signals.connect("goto_from", _on_goto_from);

func change_level(path_to: String, spawn_id: int) -> void:
	print("loading level... ", path_to);
	Signals.unload_level.emit();
	Signals.load_level.emit(path_to, spawn_id, false);
	print("ll call done!");

func _on_goto_from(from_where: int, exit_id: int, to_where: int, spawn_id: int) -> void:
	print("asked to leave level %d from exit number %d, entering level %d into spawn number %d" %
		[from_where, exit_id, to_where, spawn_id]);
	change_level("res://Scenes/Levels/level_%d.tscn" % [to_where], spawn_id);
