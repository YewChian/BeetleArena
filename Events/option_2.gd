extends Button



func _on_pressed():
	get_tree().change_scene_to_file("res://Map.tscn")

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
