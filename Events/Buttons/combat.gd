extends TextureButton

@onready var button_name = name

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if disabledbuttons.disabled_dictionary[button_name]== 0 :
		texture_normal= load("res://Assets/UI/ArenaButtonCompleted.png")
	
	
func _on_pressed():
	if disabledbuttons.disabled_dictionary[button_name]== 1 and GroupsNTiers.group_dictionary[button_name]== GroupsNTiers.current_tier + 1:
		get_tree().change_scene_to_file("res://Events/arena.tscn")
		disabledbuttons.disabled_dictionary[button_name] = 0
		ArenaInfo.current_difficulty += 1 
		GroupsNTiers.current_tier += 1 
