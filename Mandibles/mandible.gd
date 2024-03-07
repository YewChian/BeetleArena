extends Area2D
class_name Mandible

var WallDetector_mandible_attachment_vector
var str

func _ready():
	initialise_stats()
	

func initialise_stats():
	pass
	
	
func disable_hitbox():
	$Hitbox.queue_free()
