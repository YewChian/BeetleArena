extends HBoxContainer

var beetle : Object

func initialize_healthbar():
	get_node("NameContainer/NameLabel").text = beetle.nickname
	get_node("Healthbar").max_value = beetle.end

func update_healthbar():
	get_node("Healthbar").value = beetle.end

func _process(delta):
	if beetle != null:
		update_healthbar()
