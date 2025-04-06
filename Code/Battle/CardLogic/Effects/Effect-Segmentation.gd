extends CardEffect

class_name Effect_Segmentation

func _init(applicator: Card, target: Card) -> void:
	texture = preload("res://assets/Icons/Buff Icon.png")
	super._init(applicator, target)
	events = [Event_StartOfRound.new()]
	
func execute(event: Event):
	applicator.flashCard()
	var gold = applicator.cardOwner.battleResources.gold
	if gold < 6:
		applicator.cardOwner.gainGold(2)
	if gold < 8:
		applicator.cardOwner.drawCards(1)
	if gold < 10:
		applicator.cardOwner.activeCharacter.gainEnergy()
