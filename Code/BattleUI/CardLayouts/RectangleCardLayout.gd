extends CardLayout

class_name RectangleCardLayout

func arrangeCards():
	var num_cards = get_child_count()
	if num_cards == 0:
		return
	
	var i = 1
	var arrayStart = 0 - (ARRAY_WIDTH / 2)
	var cardOffset = ARRAY_WIDTH / (num_cards + 1)
	# Position each card
	for card in addedCards:
		if card is Node2D:
			if i == 1:
				card.position = Vector2(CENTER_X - 70 , CENTER_Y + 98)
				card.setBasePosition(card.position)
			elif i == 2:
				card.position = Vector2(CENTER_X + 70 , CENTER_Y + 98)
				card.setBasePosition(card.position)
			elif i == 3:
				card.position = Vector2(CENTER_X - 70 , CENTER_Y - 98)
				card.setBasePosition(card.position)
			elif i == 4:
				card.position = Vector2(CENTER_X + 70 , CENTER_Y - 95)
				card.setBasePosition(card.position)
			i = i + 1
