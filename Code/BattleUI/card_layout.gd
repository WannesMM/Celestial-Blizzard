extends Node2D

# Constants for card size in pixels (A4 vertical size in your game) 210
var ARRAY_WIDTH = 700
var CENTER_Y = 150
var CENTER_X = 0
var CARD_SCALE = 1
var ADDEDCARDS = []
var CARD_LAYOUT_TYPE = "AllyLayout"
const ANIMATIONSCALE = Vector2(1.19,1.19)
const ANIMATIONDURATION: float = 0.19
const SELECTMOVEMENT = Vector2(0,-25)
const HOLDTRESHHOLD = 0.15
var anchorPosition: Vector2 = Vector2(0,0)

var cardBeingDragged
var selectedCard
var screenSize
var isPressed = false
var holdTimer = 0.0

signal signalAddExistingCard

func _ready():
	screenSize = get_viewport_rect().size
	assignConstants()
	addInitialCards()
	arrange_cards()
	
func connectSignal(card):
	if card.has_signal("cardMouseEntered"):
		card.connect("cardMouseEntered", Callable(self, "cardMouseEntered"))
	if card.has_signal("cardMouseExited"):
		card.connect("cardMouseExited", Callable(self, "cardMouseExited"))

func cardMouseEntered(card):
	print("cardMouseEntered")
	if !cardBeingDragged:
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
		#card.moveCardUpSelect(SELECTMOVEMENT)
	
func cardMouseExited(card):
	card.undoHighlightCard()
	card.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
	#card.moveCardDownSelect()

func _process(delta: float) -> void:
	pass
	
func assignConstants():
	ARRAY_WIDTH = ARRAY_WIDTH
	CENTER_Y = CENTER_Y
	CENTER_X = CENTER_X
	CARD_SCALE = CARD_SCALE
	CARD_LAYOUT_TYPE = CARD_LAYOUT_TYPE

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
		if card is Node2D:
			card.position = Vector2(arrayStart + ((i + 1) * cardOffset) + CENTER_X , CENTER_Y)
			card.setBasePosition(card.position)
			#print("my position is " + str(card.position))

func returnToBasePosition(card):
	card.position = card.getBasePosition()

func addCard(cardLogic):
	var cardScene = load("res://Scenes/card.tscn")
	
	if cardScene is PackedScene:  # Ensure it is a PackedScene
		var newCard = cardScene.instantiate()  # Create an instance of the card scene
		
		newCard.setCard(cardLogic)
		
		newCard.assignDefaultScale(Vector2(CARD_SCALE,CARD_SCALE))
		
		connectSignal(newCard)
		add_child(newCard)  # Add the new card to the parent node
		ADDEDCARDS.append(newCard)
		newCard.setLayout(self)
		
		arrange_cards()  # Optionally call your arrange function to reposition cards
	else:
		print("Failed to load the card scene!")
	
func addExistingCard(card):
	add_child(card)  # Add the new card to the parent node
	ADDEDCARDS.append(card)
	card.setLayout(self)
		
	arrange_cards()

func removeExistingCard(card):
	remove_child(card)
	ADDEDCARDS.erase(card)
	card.setLayout(null)
	
	arrange_cards()

func addCardToLayout(card, layout):
	card.getLayout().removeExistingCard(card)
	
	layout.addExistingCard(card)
	arrange_cards()
	
func moveCardBasePosition(card):
	card.position = card.getBasePosition()
	
func addInitialCards():
	var greon = NomaGreon.new()
	var bartholomew = BartholomewBalderstone.new()
	var torinn = TorinnInn.new()
	
	addCard(greon)
	addCard(bartholomew)
	addCard(torinn)
	
	
