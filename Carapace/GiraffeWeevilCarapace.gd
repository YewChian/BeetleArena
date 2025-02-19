extends Carapace

func initialise_stats():
	part_name = ""
	for key in PartsInfo.name_to_path:
		if PartsInfo.name_to_path[key] == scene_file_path:
			part_name = key
	assert(part_name != "")		# part name should be found in PartsInfo.name_to_path
	end = 2
	left_leg_attachment_vector = Vector2(-151, 100)
	WallDetector_carapace_attachment_vector = Vector2(0, 0)
