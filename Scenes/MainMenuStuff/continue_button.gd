extends Button

func _on_pressed() -> void:
	SaveManager.load_save();
	Signals.load_level.emit("res://Scenes/Levels/level_" + str(PlayerMetrics.last_level_id) + ".tscn");
	Signals.load_player.emit(PlayerMetrics.last_spawn_id);
