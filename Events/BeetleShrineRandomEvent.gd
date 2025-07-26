extends Control

var main_beetle: Object
var beetle_list_element_resource: Resource = preload("res://Events/BeetleListElement.tscn")


func _ready() -> void:
	for beetle_name in Inventory.beetles:
		var new_element = beetle_list_element_resource.instantiate()
		new_element.get_node("Name").pressed.connect(_on_element_pressed.bind(new_element))
		%BeetleList.add_child(new_element)
		new_element.beetle_name = beetle_name
		await new_element.update_info()
	%Endure.set_deferred("disabled", true)


func _on_endure_pressed() -> void:
	var burn_percentage: float = 0.1
	
	randomize()
	var shrine_roll = randi_range(0,100)
	if shrine_roll <= (burn_percentage * 100):
		main_beetle.burn()
		%EndDialog.visible = true
		%EndDialog.dialog_text = str(main_beetle.nickname) + " is cooked. Yummy."
		
	else:
		main_beetle.enhance_with_shrine()
		
		%GainEnduranceDialog.visible = true
		%GainEnduranceDialog.dialog_text = str(main_beetle.nickname) + " gains 1 endurance."
		burn_percentage = max(0.9, burn_percentage + 0.2)
		

func _on_leave_pressed() -> void:
		%EndDialog.visible = true
		%EndDialog.dialog_text = "The beetle drawings look at you funny as you leave the shrine."
	

func _on_element_pressed(element):
	if main_beetle != null:
		main_beetle.queue_free()
	
	main_beetle = Inventory.assemble_beetle(element.beetle_name, Inventory.beetles[element.beetle_name])
	main_beetle.team = 0
	add_child(main_beetle)
	main_beetle.global_position = Vector2(955, 318)
	main_beetle.scale = Vector2(0.1, 0.1)
	main_beetle.base_spd = 0
	
	%Endure.set_deferred("disabled", false)
	

func _on_end_dialog_confirmed() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")


func _on_gain_endurance_dialog_confirmed() -> void:
	%GainEnduranceDialog.visible = false
