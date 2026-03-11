extends Node2D

@export var pickup_id : Enums.PickupableID;

func _ready() -> void:
	$PUSprite.texture = load(Enums.pickupSprites[pickup_id]);
