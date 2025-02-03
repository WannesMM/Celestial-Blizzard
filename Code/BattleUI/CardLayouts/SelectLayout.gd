extends CardLayout

class_name SelectLayout

var amountSelectable = 1
var selectedCards: Array[Card] = []

func cardLayoutConstructor():
	movable = false
	selectable = false
	CENTER_Y = 0
	
func setAmountSelectable(amt):
	amountSelectable = amt
	
func onClick(card):
	if card in selectedCards:
		selectedCards.erase(card)
		
		card.undoHighlightCard()
		card.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
		card.moveCardDownSelect()
		
	elif amountSelectable > selectedCards.size():
		selectedCards.append(card)
		
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
		card.moveCardUpSelect(SELECTMOVEMENT)
		
	elif amountSelectable <= selectedCards.size():
		
		selectedCards[0].undoHighlightCard()
		selectedCards[0].scaleRelative(Vector2(1,1), ANIMATIONDURATION)
		selectedCards[0].moveCardDownSelect()
		
		selectedCards.pop_front()	
		
		selectedCards.append(card)
		
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
		card.moveCardUpSelect(SELECTMOVEMENT)
	
