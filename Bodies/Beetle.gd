extends CharacterBody2D
class_name Beetle

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
var is_invulnerable = false


func _ready():
	initialise_stats()
	enter_state(Wander)


func initialise_stats():
	spd = 1
	str = 1
	end = 2
	
	#spd = get_node("LeftLeg").get_children()[0].spd
	#str = get_node("Mandibles").get_children()[0].str
	#end = get_node("Carapace").get_children()[0].end
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#for debugging
	$End.text = str(end)
	if end <= 0:
		queue_free()
	#########
	match state:
		Wander:
			move_and_collide(direction * spd)
		
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


func _on_wall_detector_body_entered(body):
	if body.is_in_group("Wall"):
		enter_state(Pivot)


func hurtbox_area_entered(area):
	var area_owner = area.get_parent().get_parent().get_parent()
	print("area_owner: ", area_owner)
	print("self: ", self)
	if area_owner != self and is_invulnerable == false:
		is_invulnerable = true
		print("something entered the hurtbox")
		end -= 1
		$InvulnerableTimer.start()


func _on_invulnerable_timer_timeout():
	print("timed out")
	is_invulnerable = false
