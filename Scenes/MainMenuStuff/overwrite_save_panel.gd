extends Panel

func _on_no_overwrite_save_button_pressed() -> void:
	queue_free()


func _on_yes_overwrite_save_button_pressed() -> void:
	SaveManager.delete_save();
	Signals.emit_signal("load_level", Settings.startlevelpath);
	Signals.emit_signal("load_player", 0);
