extends Node

var me: CharacterBody2D;

var speed_default: float = 40000.0;
var speed_modifier: float = 1.0;
var last_direction: float = 0.0;
var jump_velocity: float = 1000.0;

var crouched : bool = false;

func input_dir_normalizer(x: float) -> float:
	if (x > 0.01):
		return 1.0;
	elif (x < -0.01):
		return -1.0;
	return 0.0;

func lose_drop_collision() -> void:
	me.set_collision_mask_value(1, false);

func gain_drop_collision() -> void:
	me.set_collision_mask_value(1, true);
