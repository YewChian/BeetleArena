extends CharacterBody2D

enum {
	Wander,
	
}

var end
var str
var spd = 1

var state = Wander
var turn_rate
var direction = Vector2(1,1)

func _ready():
	enter_state(Wander)
	$StateTimer.start(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		Wander:
			move_and_collide(direction * spd)

func enter_state(state):
	match state:
		Wander:
			var last_direction = direction
			var min_angle = -PI / 8
			var max_angle = PI / 8
			randomize()
			var angle = randf_range(min_angle, max_angle)
			direction = last_direction.rotated(angle)
			print(direction)
			rotation = direction.angle() + PI/2
			

func _on_state_timer_timeout():
	state = Wander
	enter_state(state)
