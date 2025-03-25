extends Panel

func setTexture(newTexture: Texture):
	$Control/PortraitImage.setImage(newTexture,Vector2(0,0),Vector2(0.1,0.1))
	
