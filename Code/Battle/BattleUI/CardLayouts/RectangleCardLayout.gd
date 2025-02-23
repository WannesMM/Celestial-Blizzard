extends CardLayout

class_name RectangleCardLayout

func arrangeCards():
	var num_cards = get_child_count()
	if num_cards == 0:
		return
	
	var i = 1
	# Position each card
	for card in addedCards:
		if card is Node2D:
			card.collision1()
			if i == 1:
				card.position = Vector2(- 70 , 98)
				card.setBasePosition(card.position)
				arrangeRelatedCard(card, Vector2(- 70 , 98))
			elif i == 2:
				card.position = Vector2(70 , 98)
				card.setBasePosition(card.position)
				arrangeRelatedCard(card, Vector2(70 , 98))
			elif i == 3:
				card.position = Vector2(-70 , - 98)
				card.setBasePosition(card.position)
				arrangeRelatedCard(card, Vector2(- 70 , -98))
			elif i == 4:
				card.position = Vector2(70 , - 98)
				card.setBasePosition(card.position)
				arrangeRelatedCard(card, Vector2(70 , -98))
			i = i + 1
