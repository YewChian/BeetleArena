extends CheckBox


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		RunManager.is_hardcore = true
	else:
		RunManager.is_hardcore = false
