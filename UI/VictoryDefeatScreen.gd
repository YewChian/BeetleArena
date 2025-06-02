extends CanvasLayer

func _ready() -> void:
	%OnReadySound.play()

func _on_button_pressed() -> void:
	RunManager.start_new_run()
	Inventory.beetles = {}
	Inventory.spare_parts = []
