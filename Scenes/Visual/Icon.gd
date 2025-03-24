extends Sprite2D

class_name Icon

var representative = null

func setIcon(icon: String):
	var arr = getIconPath(icon)
	$Image.setPortraitImage(arr[0], arr[1], arr[2])

func getIconPath(name: String):
	match name:
		"Burning":
			return ["res://assets/Icons/Effect/BurningIcon.jpeg", Vector2(0,0), Vector2(2,2)]
		"DQMall":
			return ["res://assets/Cards/AreaCard/DQ Mall.png", Vector2(0,0), Vector2(2,2)]
		_:
			return ["res://assets/Cards/CharacterCard/Hatsune Miku.png", Vector2(0,0), Vector2(1,1)]
