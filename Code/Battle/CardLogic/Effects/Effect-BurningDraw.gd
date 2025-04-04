extends CardEffect

func _init(applicator: Card, target: Card) -> void:
	super._init(applicator, target)
	events = [Event_Generic.new("Burning")]

func execute(event: Event):
	super.execute(event)
	applicator.flashCard()
	applicator.cardOwner.drawCards(1)
