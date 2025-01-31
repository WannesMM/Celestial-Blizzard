extends "res://Code/BattleUI/card_layout.gd"

func assignConstants():
	ARRAY_WIDTH = 700
	CENTER_Y = -40
	CENTER_X = 0
	CARD_SCALE = 1
	CARD_LAYOUT_TYPE = "CardHand"

func addInitialCards():
	var greon = HatsuneMiku.new()
	var bartholomew = BartholomewBalderstone.new()
	var torinn = HatsuneMiku.new()
	
	addCard(greon)
	addCard(bartholomew)
	addCard(torinn)
