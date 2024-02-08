extends CharacterBody2D

var end

func _on_hurtbox_area_entered(area):
	print("area entered")
	var beetle_parent = get_parent().get_parent()
	beetle_parent.hurtbox_area_entered(area)
