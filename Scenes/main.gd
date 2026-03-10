extends Node

@export_file("*.tscn") var default_level_path : String = "";
var default_level : Node2D;
var loaded_level : Node2D;

@onready var pc_ps : PackedScene = preload("res://Character/pc.tscn");
var pc : CharacterBody2D;

func load_level(level_path: String, spawn_number: int, default_spawn: bool) -> void:
	loaded_level = load(level_path).instantiate();
	if (!default_spawn):
		pc.position = loaded_level.get_spawn_loc(spawn_number);
	else:
		pc.position = loaded_level.get_default_spawn_loc();
	add_child(loaded_level);

func unload_level() -> void:
	loaded_level.queue_free();

func _ready() -> void:
	Signals.connect("load_level", load_level);
	Signals.connect("unload_level", unload_level);
	pc = pc_ps.instantiate();
	pc.label_state = %LabelState;
	pc.label_crouched = %LabelCrouched;
	pc.label_misc = %LabelMisc;
	pc.label_jump_held = %LabelJumpHeld;
	load_level(default_level_path, -1, true);
	add_child(pc);
