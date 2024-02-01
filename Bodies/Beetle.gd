extends CharacterBody2D

enum {
	Wander,
	Pivot,
}

var end
var str
var spd = 1

var state
var turn_rate
var direction = Vector2(1,1)


func _ready():
	enter_state(Wander)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		Wander:
			move_and_collide(direction * spd)
			if $WallDetector.is_colliding() and state != Pivot:
				enter_state(Pivot)
		
		Pivot:
			pass


func enter_state(new_state):
	match new_state:
		Wander:
			state = Wander
			var last_direction = direction
			var min_angle = -PI / 8
			var max_angle = PI / 8
			randomize()
			var angle = randf_range(min_angle, max_angle)
			direction = last_direction.rotated(angle)
			rotation = direction.angle() + PI/2
			$StateTimer.start(1)
			
			
		Pivot:
			state = Pivot
			$StateTimer.stop()
			var pivot_start_lag = 1
			await get_tree().create_timer(pivot_start_lag).timeout
			
			var temp_tween = get_tree().create_tween()
			randomize()
			var rotation_direction = randi_range(0,1)
			if rotation_direction == 0:	#left
				temp_tween.tween_property(self, "rotation", rotation - PI, 1.0)
			elif rotation_direction == 1:	#right
				temp_tween.tween_property(self, "rotation", rotation + PI, 1.0)
			direction = direction.rotated(PI)
			
			await temp_tween.finished
			enter_state(Wander)
			
			
		
func _on_state_timer_timeout():
	match state:
		Wander:
			enter_state(Wander)
