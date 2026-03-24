extends Button

signal are_you_sure_new_game;

func _on_pressed() -> void:
	if (SaveManager.has_save()):
		are_you_sure_new_game.emit();
	else:
		Signals.load_level.emit(Settings.startlevelpath);
		Signals.load_player.emit(0);
