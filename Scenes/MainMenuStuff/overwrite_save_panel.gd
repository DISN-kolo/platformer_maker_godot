extends Panel

func _on_no_overwrite_save_button_pressed() -> void:
	queue_free();

func _on_yes_overwrite_save_button_pressed() -> void:
	SaveManager.delete_save();
	Signals.load_level.emit(Settings.startlevelpath);
	Signals.load_player.emit(0);
