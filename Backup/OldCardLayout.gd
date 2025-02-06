#extends Node2D
#
#class_name CardLayout
#
#var addedCards = []
#var gamestate: PlayerState = null
#
#func getAddedCards():
	#return addedCards
	#
#func cardLayoutConstructor():
	#pass
#
##---------------------------------------------------------------------------------------------------
#
#var ARRAY_WIDTH = 700
#var CENTER_Y = 0
#var CENTER_X = 0
#var CARD_SCALE = 1
#var CARD_LAYOUT_TYPE = "AllyLayout"
#
#const ANIMATIONSCALE = Vector2(1.19,1.19)
#const ANIMATIONDURATION: float = 0.19
#const SELECTMOVEMENT = Vector2(0,-25)
#const HOLDTRESHHOLD = 0.15
#var anchorPosition: Vector2 = Vector2(0,0)
#
#var cardBeingDragged
#var selectedCard
#var screenSize
#var isPressed = false
#var holdTimer = 0.0
#var allied = true
#
##Are the cards in this layout movable
#var movable: bool = true
##Are the cards in this layout clickable
#var clickable: bool = true
##When clicked, should the game show this card's information
#var showInformation: bool = true
##Are the cards in this layout selectable
#var selectable: bool = true
##Do the cards in this layout respond when hovered over?
#var hoverable:bool = true
#
#signal signalAddExistingCard
#
#func _ready():
	#screenSize = get_viewport_rect().size
	#cardLayoutConstructor()
	#arrangeBackupSettings()
	#
#func connectSignal(card):
	#if card.has_signal("cardMouseEntered"):
		#card.connect("cardMouseEntered", Callable(self, "cardMouseEntered"))
	#if card.has_signal("cardMouseExited"):
		#card.connect("cardMouseExited", Callable(self, "cardMouseExited"))
#
#func cardMouseEntered(card):
	#print("cardMouseEntered")
	#if !cardBeingDragged and hoverable:
		#card.highlightCard()
		#card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
		##card.moveCardUpSelect(SELECTMOVEMENT)
	#
#func cardMouseExited(card):
	#card.undoHighlightCard()
	#card.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
	##card.moveCardDownSelect()
#
#func _process(delta: float) -> void:
	#pass
#
#func arrangeCard(card: Card):
	#var numCards = addedCards.size()
	#var index = addedCards.find(card)
	#var arrayStart = 0 - (ARRAY_WIDTH / 2)
	#var cardOffset = ARRAY_WIDTH / (numCards + 1)
	#
	#card.position = Vector2(arrayStart + ((index + 1) * cardOffset) + CENTER_X, CENTER_Y)
	#card.setBasePosition(card.position)
#
#func arrangeCards():
	#for card in addedCards:
		#arrangeCard(card)
#
#func returnToBasePosition(card):
	#card.position = card.getBasePosition()
#
##Create a new cardScene with given card logic and add it to this layout
#func createCard(cardLogic):
	#var cardScene = load("res://Scenes/card.tscn")
	#if cardScene is PackedScene: 
		#var newCard = cardScene.instantiate() 
		#newCard.setCard(cardLogic)
		#newCard.assignDefaultScale(Vector2(CARD_SCALE,CARD_SCALE))
		#connectSignal(newCard)
		#addCard(newCard)
	#else:
		#print("Failed to load the card scene!")
	#
##Create multiple new cards with a given array of cardLogic and add them to this layout
#func createCards(cardlogic):
	#for card in cardlogic:
		#createCard(card)
	#
#func removeAllCards():
	#var i = 0
	#var len = addedCards.size()
	#while i < len:
		#removeCard(addedCards[0])
		#i = i + 1
	#assert(addedCards == [])
	#
##Add an already existing cardScene to this layout
#func addCard(card):
	#var layout = card.getLayout()
	#if layout:
		#layout.removeExistingCard(card)
	#add_child(card)  
	#addedCards.append(card)
	#card.setLayout(self)
	#arrangeCards()
#
#func addCards(cards: Array[Card]):
	#for card in cards:
		#addCard(card)
#
##Removes an existing cardScene form this layout
#func removeCard(card):
	#remove_child(card)
	#addedCards.erase(card)
	#card.setLayout(null)
	#arrangeCards()
#
	#
##The card moves back to its base position, not sure why this code is here actually
#func moveCardBasePosition(card):
	#card.position = card.getBasePosition()
	#
##Executes when a card in this layout is clicked
#func onClick(card):
	#pass
	#
##Returns wether the cards in this layout are allowed to be dragged around
#func isMovable():
	#return movable
	#
#func setMovable(x):
	#movable = x
	#
#func isClickable():
	#return clickable
#
#func setClickable(x):
	#clickable = x
	#
#func getShowInformation():
	#return showInformation
	#
#func setShowInformation(x):
	#showInformation = x
#
#func getSelectable():
	#return selectable
#
#func setSelectable(x):
	#selectable = x
#
#func getHoverable():
	#return hoverable
	#
#func setHoverable(x):
	#hoverable = x
#
#var movableBackup = movable
#var clickableBackup = clickable
#var showInformationBackup = showInformation
#var selectableBackup = selectable
#var hoverableBackup = hoverable
#
#func arrangeBackupSettings():
	#movableBackup = movable
	#clickableBackup = clickable
	#showInformationBackup = showInformation
	#selectableBackup = selectable
	#hoverableBackup = hoverable
	#
#func disableInput():
	#setMovable(false)
	#setClickable(false)
	#setShowInformation(false)
	#setSelectable(false)
	#setHoverable(false)
	#
#func enableInput():
	#setMovable(movableBackup)
	#setClickable(clickableBackup)
	#setShowInformation(showInformationBackup)
	#setSelectable(selectableBackup)
	#setHoverable(hoverableBackup)
	#
## Testing, Remove later ----------------------------------------------------------------------------
#
#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		#arrangeCards()
