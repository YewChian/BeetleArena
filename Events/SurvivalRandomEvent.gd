extends Control

var main_beetle: Object
var beetle_list_element_resource: Resource = preload("res://Events/BeetleListElement.tscn")


func _on_a_fight_breaks_out_pressed() -> void:
	var owned_beetles: Array = []
	for beetle in Inventory.beetles:
		owned_beetles.append(beetle)
	assert(len(owned_beetles) != 0)

	randomize()
	owned_beetles.shuffle()

	if len(owned_beetles) == 1:
		%EndDialog.visible = true
		%EndDialog.dialog_text = str(owned_beetles[0]) + " has a forlorn expression. It is lonely at the top."
		return

	var winner: String = owned_beetles[0]
	var loser: String = owned_beetles[1]

	var loser_carapace = Inventory.beetles[loser]["carapace"].instantiate()
	await loser_carapace.initialise_stats()
	Inventory.beetles[winner]["bonus_end"] += loser_carapace.end + Inventory.beetles[loser]["bonus_end"]

	var loser_mandibles = Inventory.beetles[loser]["mandibles"].instantiate()
	await loser_mandibles.initialise_stats()
	Inventory.beetles[winner]["bonus_str"] += loser_mandibles.str + Inventory.beetles[loser]["bonus_str"]

	var loser_left_leg = Inventory.beetles[loser]["left_leg"].instantiate()
	await loser_left_leg.initialise_stats()
	Inventory.beetles[winner]["bonus_spd"] += loser_left_leg.base_spd + Inventory.beetles[loser]["bonus_spd"]

	Inventory.beetles.erase(loser)

	%EndDialog.visible = true
	%EndDialog.dialog_text = loser + " was devoured by " + winner  + " while it was asleep."


func _on_end_dialog_confirmed() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")
