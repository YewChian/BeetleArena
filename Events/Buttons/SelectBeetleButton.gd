extends TextureButton

@export var beetle_mandibles : Resource
@export var beetle_carapace : Resource
@export var beetle_left_leg : Resource
@export var beetle_right_leg : Resource
@export var beetle_nature : String
@export var splash_art : Texture2D
@export var beetle_type : String
@export var beetle_description : String
var beetle_nickname: String

func _on_pressed():
	owner.new_beetle_info = {
		"mandibles": beetle_mandibles,
		"carapace": beetle_carapace,
		"left_leg": beetle_left_leg,
		"right_leg": beetle_right_leg,
		"nature": beetle_nature,
		"bonus_end": 1,
		"bonus_str": 0,
		"bonus_spd": 0,
	}
	owner.set_splash_texture(splash_art)
	owner.set_beetle_type(beetle_type)
	owner.set_description(beetle_description)
