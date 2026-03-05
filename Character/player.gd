extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var label_state: Label;

@onready var label_misc: Label;

@onready var controllers: Node = $Controllers;

@onready var state_machine: StateMachine = $Controllers/StateMachine;

var lagging_speed_len : float = 0;

func _ready() -> void:
	state_machine.state_changed.connect(_on_state_changed.bind(label_state));
	state_machine.init(self);

func _unhandled_input(event) -> void:
	state_machine.process_input(event);

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta);

	if (Settings.debugmode):
		label_misc.text = "";
		label_misc.text += "
pos: %8.2f, %8.2f
vel: %8.2f, %8.2f
" % [
			position.x, position.y,
			velocity.x, velocity.y];

func _process(delta: float) -> void:
	state_machine.process_default(delta);

func _on_state_changed(state_name: String, label: Label) -> void:
	if (Settings.debugmode):
		label.set_text(state_name);
