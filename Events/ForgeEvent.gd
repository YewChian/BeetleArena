extends Node2D

@onready var beetle_list: Object = %BeetleList
var beetle_list_element_resource: Resource = preload("res://Events/BeetleListElement.tscn")
var main_beetle: Object
var temp_beetle_info: Dictionary = {}
var selected_part_button: Object = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%AcceptDialog.add_cancel_button("CANCEL")
	
	for beetle_name in Inventory.beetles:
		var new_element = beetle_list_element_resource.instantiate()
		new_element.get_node("Name").pressed.connect(_on_element_pressed.bind(new_element))
		beetle_list.add_child(new_element)
		new_element.beetle_name = beetle_name
		await new_element.update_info()
	
	var temp_part: Object
	for part in Inventory.spare_parts:
		temp_part = part.instantiate()
		if temp_part.is_in_group("Mandible"):
			await create_right_bar_element(%MandibleBox, part)
			continue
		if temp_part.is_in_group("Carapace"):
			await create_right_bar_element(%CarapaceBox, part)
			continue
		if temp_part.is_in_group("Legs"):
			await create_right_bar_element(%LegsBox, part)
			continue
			

func create_right_bar_element(parent_box: Object, part: Resource):
	var new_element = load("res://Events/BeetlePartListElement.tscn").instantiate()
	new_element.part = part
	var temp_part = part.instantiate()
	new_element.pressed.connect(_on_part_button_pressed.bind(new_element))
	add_child(temp_part)
	temp_part.visible = false
	parent_box.add_child(new_element)
	new_element.text = temp_part.part_name
	temp_part.queue_free()


func _on_part_button_pressed(element):
	selected_part_button = element
	var main_beetle_info = Inventory.beetles[main_beetle.nickname].duplicate(true)
	var temp_part = element.part.instantiate()
	add_child(temp_part)
	temp_part.visible = false
	
	assert(len(temp_part.get_groups()) == 1)	# beetle parts should only be part of one group each (e.g. part of the mandible groups)
	match temp_part.get_groups()[0]:
		"Mandible":
			main_beetle_info["mandibles"] = element.part
			main_beetle.get_node("Mandibles").get_child(0).get_node("Hitbox/CollisionShape2D").disabled = true
		"Carapace":
			main_beetle_info["carapace"] = element.part
			main_beetle.get_node("Carapace").get_child(0).get_node("Hurtbox/CollisionShape2D").disabled = true
		"Legs":
			main_beetle_info["left_leg"] = element.part
			var temp_leg = element.part.instantiate()
			main_beetle_info["right_leg"] = temp_part.right_leg
			temp_leg.queue_free()
		"_":
			printerr("part button in forge event is unable to find group of selected part")
			
	
	temp_beetle_info = main_beetle_info
	
	var new_beetle = Inventory.assemble_beetle(main_beetle.nickname, temp_beetle_info)
	var old_position = main_beetle.global_position
	var old_direction = main_beetle.direction
	var old_rotation = main_beetle.rotation
	main_beetle.queue_free()
	main_beetle = new_beetle
	main_beetle.team = 0
	add_child(main_beetle)
	main_beetle.global_position = old_position
	main_beetle.direction = old_direction
	main_beetle.rotation = old_rotation
	main_beetle.scale = Vector2(0.1, 0.1)
	

func _on_element_pressed(element):
	if main_beetle != null:
		main_beetle.queue_free()
	
	main_beetle = Inventory.assemble_beetle(element.beetle_name, Inventory.beetles[element.beetle_name])
	main_beetle.team = 0
	add_child(main_beetle)
	main_beetle.global_position = Vector2(0,0)
	main_beetle.scale = Vector2(0.1, 0.1)
	main_beetle.get_node("Carapace").get_child(0).get_node("Hurtbox/CollisionShape2D").disabled = true
	main_beetle.get_node("Mandibles").get_child(0).get_node("Hitbox/CollisionShape2D").disabled = true


func _on_forge_pressed() -> void:
	%AcceptDialog.visible = true
	var temp_part = selected_part_button.part.instantiate()
	add_child(temp_part)
	temp_part.visible = false
	%AcceptDialog.dialog_text = "Do you want to forge " + main_beetle.nickname + " with " + temp_part.part_name + "?"
	temp_part.queue_free()


func _on_accept_dialog_confirmed() -> void:
	Inventory.beetles[main_beetle.nickname] = temp_beetle_info
	get_tree().change_scene_to_file("res://Map.tscn")


func _on_skip_pressed() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")
