extends Control


func _on_leave_pressed() -> void:
	%EndDialog.visible = true


func _on_end_dialog_confirmed() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")


func _on_open_chest_pressed() -> void:
	randomize()
	var parts = PartsInfo.name_to_path.keys()
	parts.shuffle()
	var new_part = parts[0]
	Inventory.spare_parts.append(load(PartsInfo.name_to_path[new_part]))
	%NewPart.texture = load(PartsInfo.name_to_path[new_part]).instantiate().get_node("Sprite2D").texture
	%OpenChest.disabled = true
	%Leave.disabled = false
	%EndDialog.dialog_text = "You got a  " + new_part + "!!!"
	%EndDialog.visible = true
	
