extends Panel

@onready var level_block_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_block_panel.tscn");
@onready var level_entry_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_entry_panel.tscn");

func _ready() -> void:
	MinimapStorage.generate();
	draw_minimap();

func draw_minimap() -> void:
	for id: int in MinimapStorage.level_pos_s.keys():
		var level_panel: Panel = level_block_ps.instantiate();
		level_panel.position = MinimapStorage.level_pos_s[id];
		level_panel.size = MinimapStorage.level_sizes[id];
		add_child(level_panel);
		for j: int in range(MinimapStorage.mm_docker_pos_s[id].size()):
			var entry_panel: Panel = level_entry_ps.instantiate();
			entry_panel.position = MinimapStorage.mm_docker_pos_s[id][j] - entry_panel.size / 2;
			level_panel.add_child(entry_panel);
