extends Button

var part: Resource
@onready var forge_event_node = get_tree().current_scene

func _process(delta: float) -> void:
	if forge_event_node.main_beetle == null and disabled == false:
		set_deferred("disabled", true)
	elif forge_event_node.main_beetle != null and disabled == true:
		set_deferred("disabled", false)
