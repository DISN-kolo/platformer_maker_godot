@tool
extends Area2D

@export var the_shape : Shape2D:
	set(value):
		the_shape = value;
		if (has_node("CollisionShape2D")):
			$CollisionShape2D.shape = value;

func _ready() -> void:
	$CollisionShape2D.shape = the_shape;
