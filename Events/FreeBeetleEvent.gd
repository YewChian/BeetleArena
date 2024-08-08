extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func minigame_over():
	%MinigameOverLabel.visible = true
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Map.tscn")


func _on_game_over_yo_area_entered(area):
	minigame_over()
