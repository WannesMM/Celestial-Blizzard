extends Control

var value: float = 0: set = setValue
var min: int = 0
var max: int = 10

func initialise(newValue = 0, newMin = 0, newMax = 0):
	min = newMin
	max = newMax
	value = newValue
	createMetrics()

func setValue(newValue):
	$TitleBorder2.size.x = (size.x / (max - min)) * newValue
	
func createMetrics():
	var range = max - min
	var a = 1
	while a < range:
		var newRect = ColorRect.new()
		newRect.size.y = size.y / 3
		newRect.size.x = size.x / 40
		newRect.position = Vector2((size.x / range) * a,0)
		add_child(newRect)
		a += 1
