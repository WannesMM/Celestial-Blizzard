extends LayoutManager

var currentStartLayout: CardLayout

func startCardDrag(card: Card):
	currentStartLayout = card.getLayout()
	var drag_layer = get_tree().get_root()
	if drag_layer:
		var global_pos = card.global_position  # Store global position
		card.get_parent().remove_child(card)  # Remove from previous parent
		card.global_position = global_pos  # Restore correct position
		drag_layer.add_child(card)  # Move to global layer
		
func finishCardDrag(card: Card):
	card.get_parent().remove_child(card)
	currentStartLayout.addCard(card)
	
#Finish the drag
func finishDrag():
	var cardSlotFound = raycastCheckForCardSlot()
	
	if isValidMove(cardBeingDragged.getCardType(), cardSlotFound):		
		var layout: GridCardLayout = cardSlotFound.getRespectiveCardLayout()
		
		if layout.name == "Characters":
			var cardToBeRemoved: Card = layout.addedCards[0] 
			layout.removeCard(cardToBeRemoved)
			$CharacterPicker.find_child("CharacterPicker").addCard(cardToBeRemoved)
		
		finishCardDrag(cardBeingDragged)

		if cardSlotFound is CardCollision:
			layout = cardSlotFound.cardScene
		draggedIntoLayout(layout, cardBeingDragged)
	else:
		cardBeingDragged.animatePosition(cardBeingDragged.getBasePosition(), 0.7)
	cardBeingDragged = null


func isValidMove(cardType: String, cardSlotFound) -> bool:
	if not cardSlotFound:
		return false
	
	var destinationLayout: String = cardSlotFound.getRespectiveCardLayout().name
	if (cardType == "CharacterCard" && (destinationLayout == "DeckPicker" || destinationLayout == "Deck")) || (cardType != "CharacterCard" && (destinationLayout == "CharacterPicker" || destinationLayout == "Characters")):
		return false
		
	return true
	
