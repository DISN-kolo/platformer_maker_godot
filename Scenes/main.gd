extends Node

@export_file("*.tscn") var default_level_path : String = "";
var default_level : Node2D;

@onready var pc_ps : PackedScene = preload("res://Character/pc.tscn");
var pc : CharacterBody2D;

func _ready() -> void:
	default_level = load(default_level_path).instantiate();
	pc = pc_ps.instantiate();
	pc.label_state = %LabelState;
	pc.label_misc = %LabelMisc;
	pc.position = default_level.get_spawn_loc();
	add_child(default_level);
	add_child(pc);
