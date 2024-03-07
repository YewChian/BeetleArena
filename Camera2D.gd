extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var scroll_speed = 1000.0

func _input(event):
	# Check if the event is a mouse wheel event
	if event is InputEventMouse:
		var mouse_event = event as InputEventMouse
		# Check if the mouse wheel moved up
		if mouse_event.is_action("mouse_wheel_up"):
			move_camera_up()
		# Check if the mouse wheel moved down
		elif mouse_event.is_action("mouse_wheel_down"):
			move_camera_down()

func move_camera_up():
	# Move the camera up
	position.y -= scroll_speed * get_process_delta_time()

func move_camera_down():
	# Move the camera down
	position.y += scroll_speed * get_process_delta_time()
