extends CardLayout

class_name CharacterCardLayout

func cardLayoutConstructor():
	characterCardLayoutConstructor()
	movable = false
	ARRAY_WIDTH = 700
	#CENTER_X = 0
	CARD_SCALE = 1
	CARD_LAYOUT_TYPE = "CharacterCardLayout"
	
func characterCardLayoutConstructor():
	pass

func setCollision(card: Card):
	card.collision1and2()
