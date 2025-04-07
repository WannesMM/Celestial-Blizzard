extends Node2D

class_name Icon

func initialise(texture: Texture) -> void:
	if texture:
		$Image.texture = texture
	
func setUses(uses: String = ""):
	$Label.visible = true
	if uses == "-1":
		$Label.text = ""
	else:
		$Label.text = uses
