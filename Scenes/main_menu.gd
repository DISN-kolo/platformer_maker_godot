extends Control

@onready var overwrite_save_panel_ps : PackedScene = preload("res://Scenes/MainMenuStuff/overwrite_save_panel.tscn")
var overwrite_save_panel_node : Panel;

func _ready() -> void:
	Signals.level_loaded.connect(self_destruction_on_lvl_ldd);
	%NewGameButton.are_you_sure_new_game.connect(spawn_are_you_sure_new_game);

func _process(delta: float) -> void:
	if (SaveManager.has_save()):
		%ContinueButton.visible = true;
	else:
		%ContinueButton.visible = false;
	if (Settings.debugmode):
		%DebugButton.visible = true;
	else:
		%DebugButton.visible = false;

func self_destruction_on_lvl_ldd() -> void:
	call_deferred("queue_free");

func spawn_are_you_sure_new_game() -> void:
	overwrite_save_panel_node = overwrite_save_panel_ps.instantiate();
	add_child(overwrite_save_panel_node);
