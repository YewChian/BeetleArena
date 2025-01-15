extends LeftLeg

func initialise_stats():
	part_name = ""
	for key in PartsInfo.name_to_path:
		if PartsInfo.name_to_path[key] == scene_file_path:
			part_name = key
	assert(part_name != "")		# part name should be found in PartsInfo.name_to_path
	base_spd = 2
	aggro_spd = 20
	right_leg = load("res://Legs/CockroachLegs/CockroachRightLeg.tscn")
