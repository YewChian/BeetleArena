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
		new_beetle.global_position = Vector2(-1280, 0)
		new_beetle.team = 1
		var healthbar_container = $UI/HealthbarVBox.get_child(i)
		healthbar_container.beetle =  new_beetle
		healthbar_container.visible = true
		await healthbar_container.initialize_healthbar()
		i += 1
			
