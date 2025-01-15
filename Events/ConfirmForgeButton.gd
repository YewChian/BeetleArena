extends Button

@onready var forge_event_node = get_tree().current_scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if forge_event_node.selected_part_button != null and disabled == true:
		set_deferred("disabled", false)
