extends CardEffect

class_name Effect_BurningDraw

func _init(applicator: Card, target: Card) -> void:
	texture = preload("res://assets/Icons/Buff Icon.png")
	info = "Draw a card when a character receives burning damage"
	super._init(applicator, target)
	events = [Event_Generic.new("Burning")]

func execute(event: Event):
	super.execute(event)
	applicator.flashCard()
	applicator.cardOwner.drawCards(1)
