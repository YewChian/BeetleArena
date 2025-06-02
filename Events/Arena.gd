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
		}
	},
	1: {
		"Randy the Rancid": {
			"mandibles": load("res://Mandibles/CockroachMandibles.tscn"),
			"carapace": load("res://Carapace/CockroachCarapace.tscn"),
			"left_leg": load("res://Legs/CockroachLegs/CockroachLeftLeg.tscn"),
			"right_leg": load("res://Legs/CockroachLegs/CockroachRightLeg.tscn"),
			"nature": "Gross",
			"bonus_end": 1,
			"bonus_str": 0,
			"bonus_spd": 0,
			}
		},
		
	2: {
		"Jemimah the Just": {
			"mandibles": load("res://Mandibles/StagBeetleMandible.tscn"),
			"carapace": load("res://Carapace/StagBeetleCarapace.tscn"),
			"left_leg": load("res://Legs/StagBeetleLegs/StagBeetleLeftLeg.tscn"),
			"right_leg": load("res://Legs/StagBeetleLegs/StagBeetleRightLeg.tscn"),
			"nature": "Evil",
			"bonus_end": 1,
			"bonus_str": 0,
			"bonus_spd": 0,
			},
			
			"Billy the Broken": {
			"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
			"carapace": load("res://Carapace/LadybugCarapace.tscn"),
			"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
			"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
			"nature": "Brave",
			"bonus_end": 0,
			"bonus_str": 0,
			"bonus_spd": 0,
			}
		},	
		
		
	3: {
		"Grant the Gargantuan": {
			"mandibles": load("res://Mandibles/GiraffeWeevilMandibles.tscn"),
			"carapace": load("res://Carapace/GiraffeWeevilCarapace.tscn"),
			"left_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilLeftLeg.tscn"),
			"right_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilRightLeg.tscn"),
			"nature": "Evil",
			"bonus_end": 1,
			"bonus_str": 0,
			"bonus_spd": 0,
			}			
		},
		#"Grant the Gargantuan": {
			#"mandibles": load("res://Mandibles/GiraffeWeevilMandibles.tscn"),
			#"carapace": load("res://Carapace/GiraffeWeevilCarapace.tscn"),
			#"left_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilLeftLeg.tscn"),
			#"right_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilRightLeg.tscn"),
			#"nature": "Evil",
			#"bonus_end": 1,
			#"bonus_str": 0,
			#"bonus_spd": 0,
			#}
		#},
		
	4: {
		"Tommy the Thick": {
			"mandibles": load("res://Mandibles/TigerBeetleMandibles.tscn"),
			"carapace": load("res://Carapace/TigerBeetleCarapace.tscn"),
			"left_leg": load("res://Legs/TigerBeetleLegs/TigerBeetleLeftLeg.tscn"),
			"right_leg": load("res://Legs/TigerBeetleLegs/TigerBeetleRightLeg.tscn"),
			"nature": "Brave",
			"bonus_end": 0,
			"bonus_str": 0,
			"bonus_spd": 0,
			},
		
		"Micro the Meatball": {
			"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
			"carapace": load("res://Carapace/LadybugCarapace.tscn"),
			"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
			"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
			"nature": "Brave",
			"bonus_end": 0,
			"bonus_str": 0,
			"bonus_spd": 3,	
		},
	} 

		#
			#"Grant the Gargantuan": {
			#"mandibles": load("res://Mandibles/GiraffeWeevilMandibles.tscn"),
			#"carapace": load("res://Carapace/GiraffeWeevilCarapace.tscn"),
			#"left_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilLeftLeg.tscn"),
			#"right_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilRightLeg.tscn"),
			#"nature": "Evil",
			#"bonus_end": 1,
			#"bonus_str": 0,
			#"bonus_spd": 0,
			#}
		#},
} 


		
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



# Called when the node enters the scene tree for the first time.
func _ready():
	match ArenaInfo.current_difficulty:
		0:	
			%ArenaBGM.stream = load("res://Assets/Sounds/arena_0_bgm.mp3")
		1:
			%ArenaBGM.stream = load("res://Assets/Sounds/arena_1_bgm.mp3")
		2:
			%ArenaBGM.stream = load("res://Assets/Sounds/arena_2_bgm.mp3")
		3:
			%ArenaBGM.stream = load("res://Assets/Sounds/arena_3_bgm.mp3")
		4:
			%ArenaBGM.stream = load("res://Assets/Sounds/arena_4_bgm.mp3")
	%ArenaBGM.play()
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
		var healthbar_container = load("res://UI/ArenaHealthbarContainer.tscn").instantiate()
		$UI/HealthbarVBox.add_child(healthbar_container)
		healthbar_container.beetle =  new_beetle
		healthbar_container.visible = true
		await healthbar_container.initialize_healthbar()
		
		i += 1
	

	var enemy_inventory = enemy_beetles_per_difficulty[ArenaInfo.current_difficulty]
	for nickname in enemy_inventory:
		new_beetle = Inventory.assemble_beetle(nickname, enemy_inventory[nickname])
		add_child(new_beetle)
		new_beetle.global_position = Vector2(-1240, 0)
		new_beetle.direction = Vector2(1,0)
		new_beetle.rotation_degrees = 90
		new_beetle.team = 1
		var healthbar_container = load("res://UI/ArenaHealthbarContainer.tscn").instantiate()
		$UI/HealthbarVBox.add_child(healthbar_container)
		healthbar_container.beetle = new_beetle
		await healthbar_container.initialize_healthbar()
		i += 1
			
func start_arena_defeat_sequence():
	await get_tree().create_timer(1).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(%FadeOutCM, "color", Color(0.3, 0.3, 0.3, 1), 1)
	
	%DefeatMarginContainer.visible = true
	%DefeatLabel.text = "Your beetles have been defeated. \n"
	for beetle_name in Inventory.beetles:
		%DefeatLabel.text += beetle_name + ", \n"
	%DefeatLabel.text += "will be remembered in the beetle fighting hall of fame..."
	
func start_arena_victory_sequence():
	await get_tree().create_timer(1).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(%FadeOutCM, "color", Color(0.3, 0.3, 0.3, 1), 0.5)
	var new_loot: String = get_random_loot_name()
	Inventory.spare_parts.append(load(PartsInfo.name_to_path[new_loot]))
	var new_loot_label = Label.new()
	new_loot_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	new_loot_label.vertical_alignment = HORIZONTAL_ALIGNMENT_CENTER
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
	var team0_count = 0
	var team1_count = 0
	
	if beetle.team == 0:
		team0_count -= 1
	if beetle.team == 1:
		team1_count -= 1
		
	for node in get_children():
		if node.is_in_group("Beetles") == false:
			continue
		if node.team == 0:
			team0_count += 1
			continue
		if node.team == 1:
			team1_count += 1
			continue
			
	if team0_count != 0 and team1_count != 0:
		return
	
	if team0_count == 0:
		await start_arena_defeat_sequence()
		return
	
	print(ArenaInfo.current_difficulty)
	if team1_count == 0 and ArenaInfo.current_difficulty >= 4:
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://UI/VictoryScene.tscn")
		
	if team1_count == 0 and ArenaInfo.current_difficulty < 4:
		await start_arena_victory_sequence()
		return
	
	print("if code reaches here, the end condition for the arena is not working")
	
func _on_done_pressed() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")


func _on_back_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/DefeatScene.tscn")

	
