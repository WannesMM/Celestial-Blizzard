extends Node

class_name BattleResources

@export var goldDisplay: Label

var gold: int = 0

func gainGold(amt: int):
	gold = gold + amt
	updateDisplay()
	
func updateDisplay():
	goldDisplay.text = str(gold)
