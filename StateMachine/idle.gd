extends State

@export var controllers: Node

@export var pre_fall_state: State
@export var jump_state: State
@export var walk_state: State

func enter() -> void:
	PlayerMetrics.aux_jumps_left = PlayerMetrics.max_aux_jumps;
	super();

func process_physics(delta: float) -> State:
	if (abs(Input.get_vector("mov_left", "mov_right",
		"mov_up", "mov_down").x) >= 0.01):
		return walk_state;
	actor.velocity.x = lerp(actor.velocity.x, 0.0, 20*delta);
	controllers.fall_vel_processor();
	actor.move_and_slide();
	
	if (Input.is_action_pressed("jump")):
		if (controllers.crouched):
			controllers.lose_drop_collision();
			return pre_fall_state;
		else:
			return jump_state;
	if (!actor.is_on_floor()):
		return pre_fall_state;
	return null;
