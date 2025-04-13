extends LayoutManager

var currentStartLayout: CardLayout
var previousParent

func startCardDrag(card: Card):
	currentStartLayout = card.getLayout()
	previousParent = card.get_parent()
	card.reparent($DragLayer)
		
func finishCardDrag(card: Card):
	card.reparent(previousParent)

	
#Finish the drag
func finishDrag():
	finishCardDrag(cardBeingDragged)
	var cardSlotFound = raycastCheckForCardSlot()
	
	if isValidMove(cardBeingDragged.getCardType(), cardSlotFound):		
		var layout: GridCardLayout = cardSlotFound.getRespectiveCardLayout()
		
		if layout.name == "Characters" && len(UserInfo.getCharacters()) == 3:
			var cardToBeRemoved: Card = layout.addedCards[0] 
			layout.removeCard(cardToBeRemoved)
			$UI/CharacterPicker.find_child("CharacterPicker").addCard(cardToBeRemoved)
			UserInfo.removeActiveCharacters([cardToBeRemoved.getCardName()])
		
		
		saveMove(cardBeingDragged, layout)

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

func saveMove(card: Card, layout):
	if layout.name == "Deck" && currentStartLayout.name == "DeckPicker":
		UserInfo.addCardsToDeck([card.getCardName()])
	elif layout.name == "DeckPicker" && currentStartLayout.name == "Deck":
		UserInfo.removeCardsFromDeck([card.getCardName()])
	elif layout.name == "Characters" && currentStartLayout.name == "CharacterPicker":
		UserInfo.addActiveCharacters([card.getCardName()])
	elif layout.name == "CharacterPicker" && currentStartLayout.name == "Characters":
		UserInfo.removeActiveCharacters([card.getCardName()])
	else:
		print("card not saved, origin: ", currentStartLayout.name, " - dest: ", layout.name)
	
		

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

func _notification(what):
	if what == NOTIFICATION_SCROLL_BEGIN or what == NOTIFICATION_DRAG_END:
		# Reset card selection when scrolling happens
		deselectAllCards()

func displayCardInformation(card: Card):
	if card.getLayout().getShowInformation():
		$"Right Slider".displayCardInformation(card)
	if card.currentLayout is CharacterCardLayout and !card.active:
		card.playSwitchAnimation()
