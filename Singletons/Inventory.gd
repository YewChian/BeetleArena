extends Node

# nickname: {mandibles, carapace, left_leg, right_leg, nature, bonus_end, bonus_str, bonus_spd}
var beetles = {}
var spare_parts = [
	load("res://Mandibles/StagBeetleMandible.tscn"),	# for debugging
	load("res://Mandibles/LadybugMandibles.tscn"),	# for debugging
	load("res://Carapace/StagBeetleCarapace.tscn"),	# for debugging
	load("res://Carapace/LadybugCarapace.tscn"),	# for debugging
	load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),	# for debugging
	load("res://Legs/StagBeetleLegs/StagBeetleLeftLeg.tscn"),	# for debugging
]


func assemble_beetle(nickname: String, beetle_data: Dictionary):
	var new_beetle = load("res://Bodies/Beetle.tscn").instantiate()
	new_beetle.nickname = nickname
	new_beetle.get_node("Mandibles").add_child(beetle_data["mandibles"].instantiate())
	new_beetle.get_node("Carapace").add_child(beetle_data["carapace"].instantiate())
	new_beetle.get_node("LeftLeg").add_child(beetle_data["left_leg"].instantiate())
	new_beetle.get_node("RightLeg").add_child(beetle_data["right_leg"].instantiate())
	new_beetle.nature = beetle_data["nature"]
	new_beetle.end = beetle_data["bonus_end"]
	new_beetle.str = beetle_data["bonus_str"]
	new_beetle.base_spd = beetle_data["bonus_spd"]
	new_beetle.aggro_spd = beetle_data["bonus_spd"]

	return new_beetle
