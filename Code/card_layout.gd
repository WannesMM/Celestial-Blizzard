extends Control

# Constants for card size in pixels (A4 vertical size in your game) 210
var ARRAY_WIDTH = 700
var CENTER_Y = 150
var CENTER_X = 0
var CARD_SCALE = 0.5

func _ready():
	assignConstants()
	addInitialCards()
	arrange_cards()
	
func assignConstants():
	ARRAY_WIDTH = 700
	CENTER_Y = 150
	CENTER_X = 0
	CARD_SCALE = 0.5
	
# Arrange Node2D cards dynamically
func arrange_cards():
	var num_cards = get_child_count()
	if num_cards == 0:
		return
	
	var arrayStart = 0 - (ARRAY_WIDTH / 2)
	var cardOffset = ARRAY_WIDTH / (num_cards + 1)
	# Position each card
	for i in range(num_cards):
		var card = get_child(i)
		card.scale = Vector2(CARD_SCALE, CARD_SCALE)
		if card is Node2D:
			card.position = Vector2(arrayStart + ((i + 1) * cardOffset) + CENTER_X , CENTER_Y)
			print("my position is " + str(card.position))

func addCard():
	var cardScene = load("res://Scenes/card.tscn")
	print(cardScene)
	
	if cardScene is PackedScene:  # Ensure it is a PackedScene
		var newCard = cardScene.instantiate()  # Create an instance of the card scene
		add_child(newCard)  # Add the new card to the parent node
		arrange_cards()  # Optionally call your arrange function to reposition cards
	else:
		print("Failed to load the card scene!")
	
func addInitialCards():
	addCard()
	addCard()
	addCard()
