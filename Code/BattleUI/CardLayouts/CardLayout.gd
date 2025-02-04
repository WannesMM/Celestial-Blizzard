extends Node2D

class_name CardLayout

var addedCards = []
var gamestate: PlayerState = null

func getAddedCards():
	return addedCards
	
func cardLayoutConstructor():
	pass

#---------------------------------------------------------------------------------------------------

var ARRAY_WIDTH = 700
var CENTER_Y = 0
var CENTER_X = 0
var CARD_SCALE = 1
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
var allied = true

#Are the cards in this layout movable
var movable: bool = true
#Are the cards in this layout clickable
var clickable: bool = true
#When clicked, should the game show this card's information
var showInformation: bool = true
#Are the cards in this layout selectable
var selectable: bool = true
#Do the cards in this layout respond when hovered over?
var hoverable:bool = true

signal signalAddExistingCard

func _ready():
	screenSize = get_viewport_rect().size
	cardLayoutConstructor()
	arrangeBackupSettings()
	
func connectSignal(card):
	if card.has_signal("cardMouseEntered"):
		card.connect("cardMouseEntered", Callable(self, "cardMouseEntered"))
	if card.has_signal("cardMouseExited"):
		card.connect("cardMouseExited", Callable(self, "cardMouseExited"))

func cardMouseEntered(card):
	print("cardMouseEntered")
	if !cardBeingDragged and hoverable:
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
		#card.moveCardUpSelect(SELECTMOVEMENT)
	
func cardMouseExited(card):
	card.undoHighlightCard()
	card.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
	#card.moveCardDownSelect()

func _process(delta: float) -> void:
	pass

# Arrange Node2D cards dynamically
func arrange_cards():
	
	var num_cards = get_child_count()
	if num_cards == 0:
		return
	
	var i = 0
	var arrayStart = 0 - (ARRAY_WIDTH / 2)
	var cardOffset = ARRAY_WIDTH / (num_cards + 1)
	# Position each card
	for card in addedCards:
		if card is Node2D:
			card.position = Vector2(arrayStart + ((i + 1) * cardOffset) + CENTER_X , CENTER_Y)
			card.setBasePosition(card.position)
			#print("my position is " + str(card.position))
			i = i + 1

func returnToBasePosition(card):
	card.position = card.getBasePosition()

#Create a new cardScene with given card logic and add it to this layout
func createCard(cardLogic):
	var cardScene = load("res://Scenes/card.tscn")
	if cardScene is PackedScene: 
		var newCard = cardScene.instantiate() 
		newCard.setCard(cardLogic)
		newCard.assignDefaultScale(Vector2(CARD_SCALE,CARD_SCALE))
		connectSignal(newCard)
		addExistingCard(newCard) 
	else:
		print("Failed to load the card scene!")
	
#Create multiple new cards with a given array of cardLogic and add them to this layout
func addCards(cards):
	for card in cards:
		createCard(card)
	arrange_cards()
	
#Add an already existing cardScene to this layout
func addExistingCard(card):
	add_child(card)  
	addedCards.append(card)
	card.setLayout(self)
		
	arrange_cards()

#Removes an existing cardScene form this layout
func removeExistingCard(card):
	remove_child(card)
	addedCards.erase(card)
	card.setLayout(null)
	
	arrange_cards()

#Add an already existing cardScene from a different layout to this layout
func addCardToLayout(card):
	card.getLayout().removeExistingCard(card)
	addExistingCard(card)
	arrange_cards()
	
#The card moves back to its base position, not sure why this code is here actually
func moveCardBasePosition(card):
	card.position = card.getBasePosition()
	
#Executes when a card in this layout is clicked
func onClick(card):
	pass
	
#Returns wether the cards in this layout are allowed to be dragged around
func isMovable():
	return movable
	
func setMovable(x):
	movable = x
	
func isClickable():
	return clickable

func setClickable(x):
	clickable = x
	
func getShowInformation():
	return showInformation
	
func setShowInformation(x):
	showInformation = x

func getSelectable():
	return selectable

func setSelectable(x):
	selectable = x

func getHoverable():
	return hoverable
	
func setHoverable(x):
	hoverable = x

var movableBackup = movable
var clickableBackup = clickable
var showInformationBackup = showInformation
var selectableBackup = selectable
var hoverableBackup = hoverable

func arrangeBackupSettings():
	movableBackup = movable
	clickableBackup = clickable
	showInformationBackup = showInformation
	selectableBackup = selectable
	hoverableBackup = hoverable
	
func disableInput():
	setMovable(false)
	setClickable(false)
	setShowInformation(false)
	setSelectable(false)
	setHoverable(false)
	
func enableInput():
	setMovable(movableBackup)
	setClickable(clickableBackup)
	setShowInformation(showInformationBackup)
	setSelectable(selectableBackup)
	setHoverable(hoverableBackup)
	
