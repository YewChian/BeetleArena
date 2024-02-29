extends CharacterBody2D
class_name Carapace

var end

var left_leg_attachment_vector
var WallDetector_carapace_attachment_vector

func _ready():
	initialise_stats()
 
	
func initialise_stats():
	pass
	

func _on_hurtbox_area_entered(area):
	var beetle_parent = get_parent().get_parent()
	beetle_parent.hurtbox_area_entered(area)
