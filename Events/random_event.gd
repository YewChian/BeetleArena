extends Node2D
@onready var event



func event_1(): 
	print("event1")
func event_2(): 
	print("event2")
func event_3(): 
	print("event3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	event = randi_range(1,3)
	print(str(event))
	$CanvasLayer/VBoxContainer/TextureRect.texture=load("res://Assets/Backgrounds/random_event_"+str(event)+".png")
	$CanvasLayer/VBoxContainer/Option_1.string= ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
