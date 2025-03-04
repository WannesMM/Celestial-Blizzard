extends Node2D

var icons: Array[Icon] = []
@export var iconDistance = Vector2(-35,0)

func addIcon(icon):
	icons.append(icon)
	add_child(icon)
	arrangeIcons()
	
func arrangeIcons():
	var i = 0
	for icon in icons:
		icon.position = i*iconDistance
		i += 1

func removeIcon(icon: Icon):
	icons.erase(icon)
	remove_child(icon)
	arrangeIcons()
