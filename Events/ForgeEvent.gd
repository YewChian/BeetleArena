extends Node2D

@onready var beetle_list: Object = %BeetleList
var beetle_list_element_resource: Resource = preload("res://Events/BeetleListElement.tscn")
var main_beetle: Object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	var new_element = Button.new()
	var temp_part = part.instantiate()
	add_child(temp_part)
	temp_part.visible = false
	parent_box.add_child(new_element)
	new_element.text = temp_part.part_name
	
	temp_part.queue_free()

func _on_element_pressed(element):
	if main_beetle != null:
		main_beetle.queue_free()
	
	main_beetle = Inventory.assemble_beetle(element.beetle_name, Inventory.beetles[element.beetle_name])
	main_beetle.team = 0
	add_child(main_beetle)
	main_beetle.global_position = Vector2(0,0)
	main_beetle.scale = Vector2(0.1, 0.1)
