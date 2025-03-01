extends LayoutManager

func startDrag():
	var card = raycastCheckForCard()
	if card and card.getLayout().isMovable():
		cardBeingDragged = card

func finishDrag():
	var cardSlotFound = raycastCheckForCardSlot()
	if cardSlotFound:
		var layout = cardSlotFound.getRespectiveCardLayout()
		draggedIntoLayout(layout, cardBeingDragged)
	else:
		cardBeingDragged.animatePosition(cardBeingDragged.getBasePosition(), 0.7)
	cardBeingDragged = null
