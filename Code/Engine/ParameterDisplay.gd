extends Control

var value: float
var min: int
var max: int

#func _ready() -> void:
	#initialise(7,0,10)

func initialise(newValue = 0, newMin = 0, newMax = 0, newColor = Color.MAROON):
	min = newMin
	max = newMax
	value = newValue
	setColor(newColor)
	createMetrics()
	
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
	$TitleBorder2.custom_minimum_size.x = ((size.x / (max - min)) * value) + 1

func setColor(color: Color):
	$TitleBorder2/Liquid.modulate = color

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		createMetrics()
