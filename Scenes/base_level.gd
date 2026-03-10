extends Node2D

@export var level_id: int = 0;

func get_spawn_loc(spawn_id: int) -> Vector2:
	print(get_node("SpawnMarkers/Spawn%d" % [spawn_id]));
	return get_node("SpawnMarkers/Spawn%d" % [spawn_id]).position;

func _ready() -> void:
	%ExitAreas.set_level_id_to_exits(level_id);
