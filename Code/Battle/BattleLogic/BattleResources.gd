extends Control

class_name BattleResources

@export var goldDisplay: Label

var gold: int = 0: set = setGold

func setGold(amt: int):
	gold = amt
	updateDisplay()

func gainGold(amt: int):
	gold = gold + amt
	updateDisplay()
	
func reduceGold(amt: int):
	assert(gold - amt > -1)
	gold = gold - amt
	updateDisplay()
	
func updateDisplay():
	goldDisplay.text = str(gold)
