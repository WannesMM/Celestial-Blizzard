extends Sprite2D

class_name Icon

func initialise(texture: Texture) -> void:
	$Image.texture = texture

func setUses(uses: String = ""):
	if uses == "-1":
		$Label.text = ""
	else:
		$Label.text = uses

func getIconPath(name: String):
	match name:
		"Burning":
			return ["res://assets/Icons/Effect/BurningIcon.jpeg", Vector2(0,0), Vector2(2,2)]
		"DQMall":
			return ["res://assets/Cards/AreaCard/DQ Mall.png", Vector2(0,0), Vector2(2,2)]
		"Hunter's Mark":
			return ["res://assets/Icons/Effect/Hunter's Mark.png", Vector2(0,0), Vector2(1.5,1.5)]
		_:
			return ["res://assets/Cards/CharacterCard/Hatsune Miku.png", Vector2(0,0), Vector2(1,1)]
