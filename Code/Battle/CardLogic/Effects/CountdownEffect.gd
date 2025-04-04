extends CardEffect

class_name CountdownEffect

var counter: int

func _init(applicator: Card, target: Card, counter: int) -> void:
	super._init(applicator, target)
	self.counter = counter

func execute(event: Event):
	super.execute(event)

func setCounter(counter: int):
	self.counter = counter
	icon.setUses(str(counter))
