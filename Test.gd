extends Control

@export var cardScene = "res://Scenes/Main/Card.tscn"
@export var cardScript = "res://Code/Battle/CardLogic/Character/HatsuneMiku.gd"

var card: Card

func _init() -> void:
	card = load(cardScene).instantiate()
	card.set_script(load(cardScript) as Script)
	add_child(card)
	
