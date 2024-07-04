extends TextureButton

@export var beetle : Resource
@export var beetle_button_texture : CompressedTexture2D

func _ready():
	texture_normal = beetle_button_texture

func _on_pressed():
	Inventory.beetles = []
	Inventory.beetles.append(beetle)
	print(Inventory.beetles)
	

