extends Node2D

#enemy beetles per difficulty from 0 to 3
var enemy_beetles_per_difficulty = {
	0: {
		"Herbert the Hurtful": {
			"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
			"carapace": load("res://Carapace/LadybugCarapace.tscn"),
			"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
			"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
			"nature": "Brave",
			"bonus_end": 0,
			"bonus_str": 0,
			"bonus_spd": 0,
		},
	},
	1: {
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
}


# Called when the node enters the scene tree for the first time.
func _ready():
	await initialize_player_beetles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func initialize_player_beetles():
	var new_beetle : Object
	var i : int = 0
	#debug modifying inventory
	#Inventory.beetles = [load("res://Bodies/LadyBug.tscn"), load("res://Bodies/LadyBug.tscn")]
	#end debug
	for nickname in Inventory.beetles:
		new_beetle = Inventory.assemble_beetle(nickname, Inventory.beetles[nickname])
		new_beetle.team = 0
		add_child(new_beetle)
		new_beetle.global_position = Vector2(1280, 0)
		var healthbar_container = $UI/HealthbarVBox.get_child(i)
		healthbar_container.beetle =  new_beetle
		healthbar_container.visible = true
		await healthbar_container.initialize_healthbar()
		
		i += 1
	

	var enemy_inventory = enemy_beetles_per_difficulty[ArenaInfo.current_difficulty]
	for nickname in enemy_inventory:
		new_beetle = Inventory.assemble_beetle(nickname, enemy_inventory[nickname])
		add_child(new_beetle)
		new_beetle.global_position = Vector2(640, 0)
		new_beetle.direction = Vector2(1,0)
		new_beetle.rotation_degrees = 90
		new_beetle.team = 1
		var healthbar_container = $UI/HealthbarVBox.get_child(i)
		healthbar_container.beetle =  new_beetle
		healthbar_container.visible = true
		await healthbar_container.initialize_healthbar()
		i += 1
			
func start_arena_defeat_sequence():
	var tween = get_tree().create_tween()
	tween.tween_property(%FadeOutCM, "color", Color(0.3, 0.3, 0.3, 1), 1)
	
	%DefeatMarginContainer.visible = true
	%DefeatLabel.text = "Your beetles have been defeated. \n"
	for beetle_name in Inventory.beetles:
		%DefeatLabel.text += beetle_name + ", \n"
	%DefeatLabel.text += "will be remembered in the beetle fighting hall of fame..."
	
func start_arena_victory_sequence():
	var tween = get_tree().create_tween()
	tween.tween_property(%FadeOutCM, "color", Color(0.3, 0.3, 0.3, 1), 0.5)
	var new_loot: String = get_random_loot_name()
	Inventory.spare_parts.append(load(PartsInfo.name_to_path[new_loot]))
	var new_loot_label = Label.new()
	new_loot_label.text = "Got a " + new_loot + "!"
	%RewardList.add_child(new_loot_label)
	%VictoryMarginContainer.visible = true
	

func get_random_loot_name():
	var all_loot = []
	for part_name in PartsInfo.name_to_path:
		all_loot.append(part_name)
	randomize()
	all_loot.shuffle()
	return all_loot[0]

func on_beetle_death(beetle: Object):
	if beetle.team == 0:
		await start_arena_defeat_sequence()
		return
		
	var beetle_count = 0
	for node in get_children():
		if beetle_count > 1:
			return
		if node.is_in_group("Beetles"):
			beetle_count += 1
			
	await start_arena_victory_sequence()
	
func _on_done_pressed() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")


func _on_back_to_title_pressed() -> void:
	RunManager.start_new_run()
	Inventory.beetles = {}
	Inventory.spare_parts = {}
	
