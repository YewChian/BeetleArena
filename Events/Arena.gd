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
	for beetle in Inventory.beetles:
		print("creating beetle")
		new_beetle = beetle.instantiate()
		new_beetle.team = 0
		add_child(new_beetle)
