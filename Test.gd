extends Control

@export var cardScene = "res://Scenes/Main/Card.tscn"
@export var cardScript = "res://Code/Battle/CardLogic/Character/HatsuneMiku.gd"

var card: Card

func _init() -> void:
	add_child(Load.loadCards(["Hatsune Miku"])[0])
	
