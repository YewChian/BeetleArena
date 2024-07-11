extends HBoxContainer

var beetle : Object

func initialize_healthbar():
	get_node("NameContainer/NameLabel").text = beetle.name
	get_node("Healthbar").max_value = beetle.end

func update_healthbar():
	get_node("Healthbar").value = beetle.end

func _process(delta):
	update_healthbar()
