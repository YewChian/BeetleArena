extends TextureButton

@export var beetle : Resource
@export var splash_art : Texture2D
@export var beetle_type : String
@export var beetle_description : String

func _on_pressed():
	Inventory.beetles = []
	Inventory.beetles.append(beetle)
	owner.set_splash_texture(splash_art)
	owner.set_beetle_type(beetle_type)
	owner.set_description(beetle_description)

