extends Node2D
class_name Mandibles

var WallDetector_mandible_attachment_vector
var str
var part_name

func _ready():
	initialise_stats()
	

func initialise_stats():
	pass
	
	
func disable_hitbox():
	$Hitbox.queue_free()
