extends Control

var value: float = 0: set = setValue
var min: int = 0
var max: int = 10

func initialise(value = 0, min = 0, max = 0):
	createMetrics()

func setValue(newValue):
	pass
	
func createMetrics():
	var range = max - min
	var a = 1
	while a <= range:
		var newRect = ColorRect.new()
		newRect.size.y = size.y / 3
		newRect.size.x = size.x / 150
		newRect.position = Vector2((size.x / range) * a,0)
		add_child(newRect)
		a += 1
		
func _ready() -> void:
	initialise()
