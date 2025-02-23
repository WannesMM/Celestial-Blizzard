extends AreaSupportLayout

func areaSupportConstructor():
	allied = true
	CARD_LAYOUT_TYPE = "AllyAreaSupport"
	$"../AllyCollider".disableCollision()
