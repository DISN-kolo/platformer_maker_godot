extends Node2D

@export var level_id: int = 0;
@onready var disappearing_dude_ps : PackedScene = preload("res://PickUp/disappearing_pu.tscn");
var disappearing_dude : Node2D;

func get_spawn_loc(spawn_id: int) -> Vector2:
	return get_node("SpawnMarkers/Spawn%d" % [spawn_id]).position;

func spawn_disappearing_pu(pickup_id : Enums.PickupableID, gpos : Vector2) -> void:
	disappearing_dude = disappearing_dude_ps.instantiate();
	disappearing_dude.pickup_id = pickup_id;
	disappearing_dude.global_position = gpos;
	add_child(disappearing_dude);

func _ready() -> void:
	Signals.pickupable_picked_up.connect(spawn_disappearing_pu);
	%ExitAreas.set_level_id_to_exits(level_id);
