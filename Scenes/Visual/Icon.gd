extends Node2D

class_name Icon

func initialise(texture: Texture) -> void:
	$Image.texture = texture

func setUses(uses: String = ""):
	if uses == "-1":
		$Label.text = ""
	else:
		$Label.text = uses
