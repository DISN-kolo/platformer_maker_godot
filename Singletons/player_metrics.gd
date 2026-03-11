extends Node;

var has_items : Array[Enums.PickupableID];

func _ready() -> void:
	Signals.pickupable_picked_up.connect(_on_picked_up);

func _on_picked_up(id: Enums.PickupableID, gpos: Vector2) -> void:
	if (!has_items.has(id)):
		print("pu'd ", id, " at ", gpos);
		has_items.append(id);
	else:
		print("tried to pu ", id, " at ", gpos, ", but already had that");
