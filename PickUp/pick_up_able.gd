extends Node2D;

@export var pickup_id : Enums.PickupableID;

func _ready() -> void:
	if (pickup_id in PlayerMetrics.has_items):
		queue_free();
	$PUSprite.texture = load(Enums.pickupSprites[pickup_id]);
