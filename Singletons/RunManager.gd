extends Node

var is_stag_unlocked = false
var is_hardcore: bool = false
@onready var bgm = AudioStreamPlayer2D.new()

func start_new_run():
	Inventory.beetles = {}
	Inventory.spare_parts = []
	GroupsNTiers.current_tier = 0
	ArenaInfo.current_difficulty = -1
	for key in disabledbuttons.disabled_dictionary:
		disabledbuttons.disabled_dictionary[key] = 1
	get_tree().change_scene_to_file("res://StartRunScene.tscn")
