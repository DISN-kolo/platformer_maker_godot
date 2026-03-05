extends State

@export var controllers: Node;

@export var crouched_state: State;

func enter() -> void:
	controllers.crouched = false;
	super();

func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed("crouch"):
		return crouched_state;
	return null
