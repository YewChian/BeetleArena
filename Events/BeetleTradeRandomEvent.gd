extends Control

var main_beetle: Object
var beetle_list_element_resource: Resource = preload("res://Events/BeetleListElement.tscn")
var is_traded = false
var new_beetle = ""
var random_beetles = {
	#"Herbert the Hurtful": {
		#"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		#"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		#"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		#"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		#"nature": "Brave",
		#"bonus_end": 0,
		#"bonus_str": 0,
		#"bonus_spd": 0,
	#},
	# debug
	"Grant the Gargantuan": {
		"mandibles": load("res://Mandibles/GiraffeWeevilMandibles.tscn"),
		"carapace": load("res://Carapace/GiraffeWeevilCarapace.tscn"),
		"left_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilLeftLeg.tscn"),
		"right_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilRightLeg.tscn"),
		"nature": "Evil",
		"bonus_end": 1,
		"bonus_str": 0,
		"bonus_spd": 0,
	},
	#"Randy the Rancid": {
		#"mandibles": load("res://Mandibles/CockroachMandibles.tscn"),
		#"carapace": load("res://Carapace/CockroachCarapace.tscn"),
		#"left_leg": load("res://Legs/CockroachLegs/CockroachLeftLeg.tscn"),
		#"right_leg": load("res://Legs/CockroachLegs/CockroachRightLeg.tscn"),
		#"nature": "Gross",
		#"bonus_end": 1,
		#"bonus_str": 0,
		#"bonus_spd": 0,
	#},
	#"Tommy the Thick": {
		#"mandibles": load("res://Mandibles/TigerBeetleMandibles.tscn"),
		#"carapace": load("res://Carapace/TigerBeetleCarapace.tscn"),
		#"left_leg": load("res://Legs/TigerBeetleLegs/TigerBeetleLeftLeg.tscn"),
		#"right_leg": load("res://Legs/TigerBeetleLegs/TigerBeetleRightLeg.tscn"),
		#"nature": "Brave",
		#"bonus_end": 0,
		#"bonus_str": 0,
		#"bonus_spd": 0,
	#},
	"Diane the Dreary": {
		"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		"nature": "Brave",
		"bonus_end": 0,
		"bonus_str": 0,
		"bonus_spd": 0,
	},
	"Leon the Laughable": {
		"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		"nature": "Brave",
		"bonus_end": 0,
		"bonus_str": 0,
		"bonus_spd": 0,
	},
}

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
		main_beetle.visible = false
		%EndDialog.dialog_text = %NameLineEdit.text + " has joined you"
		Inventory.beetles[%NameLineEdit.text] = random_beetles[new_beetle]
	else:
		%EndDialog.dialog_text = "Coward..."
	

func _on_element_pressed(element):
	if main_beetle != null:
		main_beetle.queue_free()
	
	main_beetle = Inventory.assemble_beetle(element.beetle_name, Inventory.beetles[element.beetle_name])
	main_beetle.team = 0
	add_child(main_beetle)
	main_beetle.global_position = Vector2(909, 249)
	main_beetle.scale = Vector2(0.1, 0.1)
	main_beetle.base_spd = 0
	#is_traded = true
	%Trade.disabled = false
	%Trade.text = "TRADE " + element.beetle_name + " FOR A RANDOM BEETLE?"
	

func _on_end_dialog_confirmed() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")


func _on_trade_pressed() -> void:
	is_traded = true
	%BeetleList.visible = false
	%Trade.visible = false
	randomize()
	var available_beetles = random_beetles.keys()
	available_beetles.shuffle()
	new_beetle = available_beetles[0]
	%NameLineEdit.visible = true
	Inventory.beetles.erase(main_beetle.nickname)
	main_beetle.visible = false


func _process(delta: float) -> void:
	if is_traded and %NameLineEdit.text == "":
		%Leave.disabled = true
	else:
		%Leave.disabled = false
		
