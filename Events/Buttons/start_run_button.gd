extends Button

var map_scene_path = "res://Map.tscn"


func _on_pressed():
	Inventory.beetles = {
		owner.new_beetle_name: owner.new_beetle_info
	}
	get_tree().change_scene_to_file(map_scene_path)
	
func _process(delta: float) -> void:
	if owner.new_beetle_name != "" and owner.new_beetle_info != {}:
		set_deferred("disabled", false)
	else:
		set_deferred("disabled", true)
