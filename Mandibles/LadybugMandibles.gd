extends Mandibles

func initialise_stats():
	part_name = ""
	for key in PartsInfo.name_to_path:
		if PartsInfo.name_to_path[key] == scene_file_path:
			part_name = key
	assert(part_name != "")		# part name should be found in PartsInfo.name_to_path
	str = 1
	WallDetector_mandible_attachment_vector = Vector2(0, -128)
