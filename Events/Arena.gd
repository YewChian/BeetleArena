extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(Inventory.beetles)
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
		new_beetle = load("res://Bodies/Beetle.tscn").instantiate()
		new_beetle.nickname = nickname
		new_beetle.get_node("Mandible").add_child(Inventory.beetles[nickname]["mandibles"].instantiate())
		new_beetle.get_node("Carapace").add_child(Inventory.beetles[nickname]["carapace"].instantiate())
		new_beetle.get_node("LeftLeg").add_child(Inventory.beetles[nickname]["left_leg"].instantiate())
		new_beetle.get_node("RightLeg").add_child(Inventory.beetles[nickname]["right_leg"].instantiate())
		add_child(new_beetle)
		new_beetle.nature = Inventory.beetles[nickname]["nature"]
		new_beetle.end += Inventory.beetles[nickname]["bonus_end"]
		new_beetle.str += Inventory.beetles[nickname]["bonus_str"]
		new_beetle.base_spd += Inventory.beetles[nickname]["bonus_spd"]
		var healthbar_container = $UI/HealthbarVBox.get_child(i)
		healthbar_container.beetle =  new_beetle
		healthbar_container.visible = true
		await healthbar_container.initialize_healthbar()
		
		i += 1
	
	##debug adding enemy beetle
	#print("creating beetle")
	#new_beetle = load("res://Bodies/StagBeetle.tscn").instantiate()
	#new_beetle.team = 1
	#add_child(new_beetle)
	#
	#var healthbar_container = $UI/HealthbarVBox.get_children()[i]
	#healthbar_container.beetle =  new_beetle
	#await healthbar_container.initialize_healthbar()
	#end debug
