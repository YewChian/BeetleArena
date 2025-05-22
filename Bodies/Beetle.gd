extends CharacterBody2D
class_name Beetle

enum {
	Wander,
	Pivot,
	Death,
}

var end
var str
var base_spd
var aggro_spd
var team
var nickname: String
var nature: String

var state
var turn_rate
var direction = Vector2(-1,0.5)
var is_invulnerable = false


func _ready():
	initialise_stats()
	initialise_leg_attachment()
	call_deferred("initialise_WallDetector_attachment")
	enter_state(Wander)
	
	
func initialise_WallDetector_attachment():
	$WallDetector.position = $Mandibles.get_children()[0].WallDetector_mandible_attachment_vector + $Carapace.get_children()[0].WallDetector_carapace_attachment_vector


func initialise_leg_attachment():
	$LeftLeg.position = $Carapace.get_children()[0].left_leg_attachment_vector
	$RightLeg.position = $Carapace.get_children()[0].left_leg_attachment_vector * Vector2(-1, 1)


func initialise_stats():
	base_spd += get_node("LeftLeg").get_children()[0].base_spd
	aggro_spd += get_node("LeftLeg").get_children()[0].aggro_spd
	str += get_node("Mandibles").get_children()[0].str
	end += get_node("Carapace").get_children()[0].end
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	match state:
		Wander:
			#move_and_collide(direction * base_spd * 100)
			move_and_collide(direction * base_spd * 25)
				
		Death:
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
			
			
		Death:
			state = Death
			$StateTimer.stop()
			await $Mandibles.get_children()[0].disable_hitbox()
			await $Carapace.get_children()[0].disable_hurtbox()
			await $Carapace.get_children()[0].fade_out()
			get_tree().current_scene.on_beetle_death(self)
			queue_free()

func enhance_with_shrine():
	Inventory.beetles[nickname]["bonus_end"] += 1

func burn():
	var temp_carapace = Inventory.beetles[nickname]["carapace"].instantiate()
	await temp_carapace.initialise_stats()
	var carapace_end = temp_carapace.end
	Inventory.beetles[nickname]["bonus_end"] = (carapace_end * -1) + 1
	
	var temp_leg = Inventory.beetles[nickname]["left_leg"].instantiate()
	await temp_leg.initialise_stats()
	var leg_speed = temp_leg.base_spd
	Inventory.beetles[nickname]["bonus_spd"] = leg_speed * -1
	
		
func _on_state_timer_timeout():
	match state:
		Wander:
			enter_state(Wander)


func _on_wall_detector_body_entered(body):
	if body.is_in_group("Wall"):
		enter_state(Pivot)


func hurtbox_area_entered(area):
	var area_owner = area.get_parent().get_parent().get_parent()
	if area_owner.team != team and is_invulnerable == false:
		$Carapace.get_child(0).get_node("AnimationPlayer").play("flash_red")
		is_invulnerable = true
		end -= 1
		if end <= 0 and state != Death:
			enter_state(Death)
			return
		$InvulnerableTimer.start()


func _on_invulnerable_timer_timeout():
	is_invulnerable = false
