extends TextureButton

@onready var button_name = name

func _ready():
	if disabledbuttons.disabled_dictionary[button_name]== 0 :
		texture_normal= load("res://Assets/UI/ForestButtonCompleted.png")
	
	
func _on_pressed():
	if disabledbuttons.disabled_dictionary[button_name]== 1 and GroupsNTiers.group_dictionary[button_name]== GroupsNTiers.current_tier + 1 :
		get_tree().change_scene_to_file("res://Events/free_beetle_event.tscn")
		disabledbuttons.disabled_dictionary[button_name] = 0
		GroupsNTiers.current_tier += 1 
