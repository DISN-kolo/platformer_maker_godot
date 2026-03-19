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

func fall_vel_processor() -> void:
	if (me.velocity.y >= Settings.terminal_velocity):
		me.velocity.y = Settings.terminal_velocity;
	else:
		me.velocity.y += Settings.gravity;

func hor_vel_processor(input_dir: float, delta: float, accel_factor: float) -> void:
	var temp_fullmultiplier: float = (
		input_dir
		* speed_default
		* speed_modifier
		* delta);
	me.velocity.x = lerp(
		me.velocity.x,
		temp_fullmultiplier,
		accel_factor*delta);
