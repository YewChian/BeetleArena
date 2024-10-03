extends Control

var beetle_pool: Dictionary = {
	"Ladybug Tough": {
		"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		"nature": "Brave",
		"bonus_end": 1,
		"bonus_str": 0,
		"bonus_spd": 0,
	},
	"Ladybug Fast": {
		"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		"nature": "Brave",
		"bonus_end": 0,
		"bonus_str": 0,
		"bonus_spd": 1,
	},
	"Ladybug Painful": {
		"mandibles": load("res://Mandibles/LadybugMandibles.tscn"),
		"carapace": load("res://Carapace/LadybugCarapace.tscn"),
		"left_leg": load("res://Legs/LadybugLegs/LadybugLeftLeg.tscn"),
		"right_leg": load("res://Legs/LadybugLegs/LadybugRightLeg.tscn"),
		"nature": "Brave",
		"bonus_end": 0,
		"bonus_str": 1,
		"bonus_spd": 0,
	},
}


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_beetle: Object = Inventory.assemble_beetle("enter nickname here", beetle_pool[beetle_pool.keys()[randi_range(0,len(beetle_pool.keys())-1)]])
	add_child(new_beetle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func minigame_over():
	%MinigameOverLabel.visible = true
	%MinigameOverLabel.text = "Damn... why didn't you click the beetle...."
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Map.tscn")


func get_free_beetle(new_beetle: Object):
	%MinigameOverUI.visible = true
	%MinigameOverLabel.text = "YOU GOT A " + str(new_beetle) + "!!! show glowy animation and beetle here!!!"


func _on_game_over_yo_area_entered(area):
	minigame_over()


func _on_map_button_pressed() -> void:
	var beetle_nickname = %NameLineEdit.text
	printerr("need to add beetle to inventory")
	get_tree().change_scene_to_file("res://Map.tscn")
