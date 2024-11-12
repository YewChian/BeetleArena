extends Node2D
@onready var event

var events_dict = {
	#1: ["Event1", "Event2", "Event3", "Event4"],
	#2: ["Option1", "Option2", "Option3", "Option4"], 
	#3: ["Option1", "Option2", "Option3", "Option4"], # Assigns an Array to a String key.
	
	1: ["1", "Option1", "Option2"],
	2: ["2", "Option1", "Option2"],
	3: ["3", "Option1", "Option2"],
	4: ["4", "Option1", "Option2"]

	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	event = randi_range(1,3)
	$CanvasLayer/VBoxContainer/Event_Text.text=events_dict[event][0]
	$CanvasLayer/VBoxContainer/Option_1.text=events_dict[event][1]
	$CanvasLayer/VBoxContainer/Option_2.text=events_dict[event][2]
	$CanvasLayer/VBoxContainer/TextureRect.texture=load("res://Assets/Backgrounds/random_event_"+str(event)+".png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
