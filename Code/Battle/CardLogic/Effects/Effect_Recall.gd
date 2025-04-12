extends CardEffect

class_name Effect_Recall

func _init(applicator: Card, target: Card, events: Array[Event], function: Callable, icon: Texture = null) -> void:
	texture = icon
	info = "This card has scheduled it's effect"
	super._init(applicator, target)
	self.events = events
	self.recallFunction = function

var recallFunction: Callable

func execute(event: Event):
	super.execute(event)
	applicator.flashCard()
	await recallFunction.call(event)
