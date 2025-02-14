extends CharacterCardLayout

func characterCardLayoutConstructor():
	#CENTER_Y = -125
	allied = false
	CARD_LAYOUT_TYPE = "EnemyCharacterCardLayout"
	$"../EnemyCollider".disableCollision()
