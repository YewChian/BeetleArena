extends CanvasLayer


func set_splash_texture(new_texture : Texture2D):
	%SplashArt.texture = new_texture


func set_beetle_type(new_beetle_type : String):
	%BeetleType.text = new_beetle_type
	
	
func set_description(new_description : String):
	%BeetleDescription.text = new_description
