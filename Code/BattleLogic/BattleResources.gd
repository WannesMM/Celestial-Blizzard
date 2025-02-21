extends Node

class_name BattleResources

@export var goldDisplay: Label

var gold: int = 0

func setGold(amt: int):
	gold = amt
	updateDisplay()

func gainGold(amt: int):
	gold = gold + amt
	updateDisplay()
	
func updateDisplay():
	goldDisplay.text = str(gold)
