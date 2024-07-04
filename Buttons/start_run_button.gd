extends TextureButton

var map_scene_path = "res://Map.tscn"


func _on_pressed():
	get_tree().change_scene_to_file(map_scene_path)
