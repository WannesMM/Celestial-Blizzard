extends CardEffect

class_name Effect_Recall

func _init(applicator: Card, target: Card, events: Array[Event], function: Callable) -> void:
	texture = preload("res://assets/Icons/Gear Icon.png")
	super._init(applicator, target)
	self.events = events
	self.recallFunction = function

var recallFunction: Callable

func execute(event: Event):
	super.execute(event)
	applicator.flashCard()
	recallFunction.call()
