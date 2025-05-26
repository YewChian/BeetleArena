extends Control

var obtained_beetle_nickname = null

var beetle_pool: Dictionary = {
	"Toughbug": {
		"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		"nature": "Brave",
		"bonus_end": 1,
		"bonus_str": 0,
		"bonus_spd": 0,
	},
	"Ladybugger": {
		"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		"nature": "Brave",
		"bonus_end": 0,
		"bonus_str": 0,
		"bonus_spd": 1,
	},
	"Spotted Ladybug": {
		"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		"nature": "Brave",
		"bonus_end": 0,
		"bonus_str": 1,
		"bonus_spd": 0,
	},
	"Smelly Guy": {
		"mandibles": load("res://Mandibles/CockroachMandibles.tscn"),
		"carapace": load("res://Carapace/CockroachCarapace.tscn"),
		"left_leg": load("res://Legs/CockroachLegs/CockroachLeftLeg.tscn"),
		"right_leg": load("res://Legs/CockroachLegs/CockroachRightLeg.tscn"),
		"nature": "Gross",
		"bonus_end": 1,
		"bonus_str": 0,
		"bonus_spd": 0,
	},
	"Spookybugger": {
		"mandibles": load("res://Mandibles/GiraffeWeevilMandibles.tscn"),
		"carapace": load("res://Carapace/GiraffeWeevilCarapace.tscn"),
		"left_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilLeftLeg.tscn"),
		"right_leg": load("res://Legs/GiraffeWeevilLegs/GiraffeWeevilRightLeg.tscn"),
		"nature": "Evil",
		"bonus_end": 0,
		"bonus_str": 0,
		"bonus_spd": 0,
	},
	#stag
}


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var random_beetle_name = beetle_pool.keys()[randi_range(0,len(beetle_pool.keys())-1)]
	var random_beetle: Object = Inventory.assemble_beetle(random_beetle_name, beetle_pool[random_beetle_name])
	random_beetle.scale = Vector2(0.2, 0.2)
	print("before:", random_beetle.base_spd)
	add_child(random_beetle)
	random_beetle.base_spd *= 0.1 
	print("after:", random_beetle.base_spd)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if %NameLineEdit.text == "":
		$CanvasLayer/MinigameOverUI/MapButton.disabled = true
	else:
		$CanvasLayer/MinigameOverUI/MapButton.disabled = false


func minigame_over():
	%MinigameOverUI.visible = true
	%NameLineEdit.visible = false
	%MapButton.visible = false
	%MinigameOverLabel.text = "Damn... why didn't you click the beetle...."
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Map.tscn")


func get_free_beetle(new_beetle: Object):
	obtained_beetle_nickname = new_beetle.nickname
	new_beetle.process_mode = PROCESS_MODE_DISABLED
	%MinigameOverUI.visible = true
	%MinigameOverLabel.text = "Caught a " + new_beetle.nature + " " + obtained_beetle_nickname + "!!!\n"
	

func _on_game_over_yo_area_entered(area):
	minigame_over()


func _on_map_button_pressed() -> void:
	if %NameLineEdit.text in Inventory.beetles:
		%MinigameOverLabel.text = "You already have a beetle with this name."
		return
	var new_nickname = %NameLineEdit.text
	Inventory.beetles[new_nickname] = beetle_pool[obtained_beetle_nickname]

	get_tree().change_scene_to_file("res://Map.tscn")
