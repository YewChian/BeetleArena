extends Control

var main_beetle: Object
var beetle_list_element_resource: Resource = preload("res://Events/BeetleListElement.tscn")
var is_traded = false
var total_stats: int = 0
var pete_hunger = 5
var is_satisfied = false
var is_home = true

func _ready() -> void:
	for beetle_name in Inventory.beetles:
		var new_element = beetle_list_element_resource.instantiate()
		new_element.get_node("Name").pressed.connect(_on_element_pressed.bind(new_element))
		%BeetleList.add_child(new_element)
		new_element.beetle_name = beetle_name
		await new_element.update_info()
		

func _on_leave_pressed() -> void:
	%EndDialog.visible = true
	if is_traded:
		%EndDialog.visible = true
		%EndDialog.dialog_text = "Go away, bird."

	else:
		%EndDialog.visible = true
		%EndDialog.dialog_text = "Go away, bird"
	

func _on_element_pressed(element):
	if main_beetle != null:
		main_beetle.queue_free()
	
	main_beetle = Inventory.assemble_beetle(element.beetle_name, Inventory.beetles[element.beetle_name])
	main_beetle.team = 0
	add_child(main_beetle)
	main_beetle.global_position = Vector2(909, 249)
	main_beetle.scale = Vector2(0.1, 0.1)
	main_beetle.base_spd = 0
	is_traded = true
	%PeteTalks.disabled = false
	

func _on_end_dialog_confirmed() -> void:
	if is_satisfied or is_home:
		get_tree().change_scene_to_file("res://Map.tscn")
	else:
		%EndDialog.visible = false
		is_home = true


func _process(delta: float) -> void:
	if main_beetle == null:
		%PeteTalks.disabled = true

func _on_pete_talks_pressed() -> void:
	is_traded = true
	total_stats += main_beetle.end + main_beetle.str + main_beetle.base_spd
	print("total stats offered to pete: ", total_stats)
	remove_child(main_beetle)
	main_beetle.queue_free
	Inventory.beetles.erase(main_beetle.nickname)
	main_beetle = null
	
	for element in %BeetleList.get_children():
		element.queue_free()
	for beetle_name in Inventory.beetles:
		var new_element = beetle_list_element_resource.instantiate()
		new_element.get_node("Name").pressed.connect(_on_element_pressed.bind(new_element))
		%BeetleList.add_child(new_element)
		new_element.beetle_name = beetle_name
		await new_element.update_info()
	
	if total_stats > pete_hunger:
		is_home = false
		is_satisfied = true
		%EndDialog.visible = true
		%EndDialog.dialog_text = "Sift through poo..."
		
	else:
		is_home = false
		is_satisfied = false
		%EndDialog.visible = true
		%EndDialog.dialog_text = "I’m still hungry. Just a little more…"
