extends CanvasLayer
@onready var event

var events = [
	#"res://Events/BeetleShrineRandomEvent.tscn",
	#"res://Events/FreeItemRandomEvent.tscn",
	#"res://Events/BeetleTradeRandomEvent.tscn",
	#"res://Events/PeckishPeteRandomEvent.tscn",
	"res://Events/SurvivalRandomEvent.tscn",
]

func event_1(): 
	print("event1")
func event_2(): 
	print("event2")
func event_3(): 
	print("event3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var events_copy = events
	events_copy.shuffle()
	
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(events_copy[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
