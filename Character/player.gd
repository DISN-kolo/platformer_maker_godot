extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var label_state: Label;
@onready var label_crouched: Label;
@onready var label_misc: Label;
@onready var label_jump_held: Label;

@onready var controllers: Node = $Controllers;

@onready var state_machine: StateMachine = $Controllers/StateMachine;
@onready var crouch_machine: StateMachine = $Controllers/CrouchMachine;

var lagging_speed_len : float = 0;

func _ready() -> void:
	state_machine.state_changed.connect(_on_state_changed.bind(label_state));
	state_machine.init(self);
	crouch_machine.state_changed.connect(_on_state_changed.bind(label_crouched));
	crouch_machine.init(self);
	controllers.me = self;

func _unhandled_input(event) -> void:
	state_machine.process_input(event);
	crouch_machine.process_input(event);
	if event.is_action_pressed("jump"):
		label_jump_held.text = "HELD";
	if event.is_action_released("jump"):
		label_jump_held.text = "OFF";

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta);
	crouch_machine.process_physics(delta);

	if (Settings.debugmode):
		label_misc.text = "";
		label_misc.text += "coll mask: %d\n" % [collision_mask];
		label_misc.text += "aux jumps left: %d\n" % [PlayerMetrics.aux_jumps_left];
		label_misc.text += "max aux jumps : %d\n" % [PlayerMetrics.max_aux_jumps];
		label_misc.text += "
pos: %8.2f, %8.2f
vel: %8.2f, %8.2f
" % [
			position.x, position.y,
			velocity.x, velocity.y];

func _process(delta: float) -> void:
	state_machine.process_default(delta);
	crouch_machine.process_default(delta);

func _on_state_changed(state_name: String, label: Label) -> void:
	if (Settings.debugmode):
		label.set_text(state_name);
