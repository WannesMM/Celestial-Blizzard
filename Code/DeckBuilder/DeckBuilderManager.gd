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
			UserInfo.removeCardsFromCharacters([cardToBeRemoved])
		
		finishCardDrag(cardBeingDragged)
		saveMove(cardBeingDragged, cardSlotFound)

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

func saveMove(card: Card, cardSlotFound):
	if cardSlotFound is CardCollision:
		var layout: CardLayout = cardSlotFound.cardScene
		if layout.name == "Deck" && currentStartLayout.name == "DeckPicker":
			UserInfo.addCardsToDeck([card.getCardName()])
		elif layout.name == "DeckPicker" && currentStartLayout.name == "Deck":
			UserInfo.removeCardsFromDeck([card.getCardName()])
		elif layout.name == "Characters" && currentStartLayout.name == "CharacterPicker":
			UserInfo.addCardsToCharacters([card.getCardName()])
		elif layout.name == "CharacterPicker" && currentStartLayout.name == "Characters":
			UserInfo.removeCardsFromCharacters([card.getCardName()])
		

func selectCard(card: Card):
	if card in selectedCards:
		undoSelect(card)
		closeCardInformation()
	elif selectedCards.size() >= multiselect:
		undoSelect(selectedCards[0])
		highlightSelect(card)
		displayCardInformation(card)
	else:
		highlightSelect(card)
		displayCardInformation(card)

func deselectAllCards():
	var i = 0
	var len = selectedCards.size()
	while i < len:
		undoSelect(selectedCards[0])
		i = i + 1
	closeCardInformation()
	assert(selectedCards == [])

#For the information slider when selected
func closeCardInformation():
	$"Right Slider".closeCardInformation()

func displayCardInformation(card: Card):
	if card.getLayout().getShowInformation():
		$"Right Slider".displayCardInformation(card)
	if card.currentLayout is CharacterCardLayout and !card.active:
		card.playSwitchAnimation()
