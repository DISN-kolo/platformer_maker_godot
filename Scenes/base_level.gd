extends Node2D

@export var level_id: int = 0;

func get_default_spawn_loc() -> Vector2:
	return $SpawnMarkers/DefaultSpawn.position;

func get_spawn_loc(spawn_id: int) -> Vector2:
	return get_node("SpawnMarkers/Spawn%d" % [spawn_id]).position;

func _ready() -> void:
	%ExitAreas.set_level_id_to_exits(level_id);
