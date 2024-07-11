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
	Inventory.beetles = [load("res://Bodies/LadyBug.tscn"), load("res://Bodies/LadyBug.tscn")]
	#end debug
	for beetle in Inventory.beetles:
		print("creating beetle")
		new_beetle = beetle.instantiate()
		new_beetle.team = 0
		add_child(new_beetle)
		
		var healthbar_container = $UI/HealthbarVBox.get_children()[i]
		healthbar_container.beetle =  new_beetle
		await healthbar_container.initialize_healthbar()
		i += 1
	
	#debug adding enemy beetle
	print("creating beetle")
	new_beetle = load("res://Bodies/StagBeetle.tscn").instantiate()
	new_beetle.team = 1
	add_child(new_beetle)
	
	var healthbar_container = $UI/HealthbarVBox.get_children()[i]
	healthbar_container.beetle =  new_beetle
	await healthbar_container.initialize_healthbar()
	#end debug
