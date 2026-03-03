extends State

@export var controllers: Node

@export var fall_state: State
@export var walk_state: State
@export var idle_state: State

func enter() -> void:
	actor.velocity.y = controllers.jump_velocity;
	super();

var input_dir: float = 0.0;

func process_physics(delta: float) -> State:
	input_dir = Input.get_vector("mov_left", "mov_right", "mov_up", "mov_down").x;
	controllers.last_direction = input_dir;
	var temp_fullmultiplier: float = (
		input_dir
		* controllers.speed_default
		* controllers.speed_modifier
		* delta);
	actor.velocity.x = lerp(
		actor.velocity.x,
		temp_fullmultiplier,
		3*delta);
	actor.velocity.y -= Settings.gravity;
	actor.move_and_slide();
	
	if !actor.is_on_floor() and actor.velocity.y < 0:
		return fall_state;
	if actor.is_on_floor():
		if input_dir > 0.1:
			return walk_state;
		return idle_state;
	return null;
