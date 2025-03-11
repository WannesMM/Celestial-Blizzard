extends Control

func _ready() -> void:
	var animation = Load.loadAnimation("Celestial Blizzard Logo")
	add_child(animation)
	animation.play()
	
