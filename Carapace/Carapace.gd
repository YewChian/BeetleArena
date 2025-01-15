extends CharacterBody2D
class_name Carapace

var part_name
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


func fade_out():
	var fade_out_tween = get_tree().create_tween()
	fade_out_tween.tween_property($Sprite2D, "modulate", Color(155,155,155,0), 0.5)
	await fade_out_tween.finished
	return self
	

func disable_hurtbox():
	$Hurtbox.queue_free()
	remove_child($Hurtbox)


func _on_hurtbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if get_tree().current_scene.name == "FreeBeetleEvent":
		if event is InputEventMouseButton and event.pressed:
			var carapace_owner = get_parent().get_parent()
			await get_tree().current_scene.get_free_beetle(carapace_owner)
