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

var cardBeingDragged
var screenSize
var anchorPosition: Vector2 = Vector2(0,0)
var isPressed = false
var holdTimer = 0.0

signal signalAddExistingCard

func _ready():
	screenSize = get_viewport_rect().size
	assignConstants()
	addInitialCards()
	arrange_cards()
	
func _process(delta: float) -> void:
	cardFollowMouse()
	clickAndHoldLogic(delta)
	
func assignConstants():
	ARRAY_WIDTH = ARRAY_WIDTH
	CENTER_Y = CENTER_Y
	CENTER_X = CENTER_X
	CARD_SCALE = CARD_SCALE
	CARD_LAYOUT_TYPE = CARD_LAYOUT_TYPE
	
func connectSignal(card):
	if card.has_signal("cardMouseEntered"):
		card.connect("cardMouseEntered", Callable(self, "cardMouseEntered"))
	if card.has_signal("cardMouseExited"):
		card.connect("cardMouseExited", Callable(self, "cardMouseExited"))
	
func cardMouseEntered(card):
	if !cardBeingDragged:
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
		#card.moveCardUpSelect(SELECTMOVEMENT)
	
func cardMouseExited(card):
	card.undoHighlightCard()
	card.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
	#card.moveCardDownSelect()
	
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
		
		arrange_cards()  # Optionally call your arrange function to reposition cards
	else:
		print("Failed to load the card scene!")
	
func addExistingCard(card):
	print("It Executes")
	add_child(card)  # Add the new card to the parent node
	ADDEDCARDS.append(card)
		
	arrange_cards()
	
func addCardToLayout(card, cardSlot):
	print(self)
	print(card.getCardLogic().getCardName())
	var layout = cardSlot.getRespectiveCardLayout()
	print("add to " + str(layout))
	remove_child(card)
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
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			holdTimer = 0.0
			isPressed = true
		else:
			if cardBeingDragged:
					finishDrag()
					isPressed = false
			elif holdTimer < HOLDTRESHHOLD:
				holdTimer = 0.0
				isPressed = false		

func clickAndHoldLogic(delta):
	if isPressed:
		holdTimer += delta
		if holdTimer >= HOLDTRESHHOLD and !(cardBeingDragged):
			startDrag()
			isPressed == false
			holdTimer = 0.0
	
func startDrag():
	var card = raycastCheckForCard()
	if card:
		cardBeingDragged = card
		
func finishDrag():
	var cardSlotFound = raycastCheckForCardSlot()
	if cardSlotFound and (cardSlotFound.getRespectiveCardLayout() != self):
		addCardToLayout(cardBeingDragged, cardSlotFound)
	else:
		moveCardBasePosition(cardBeingDragged)
	cardBeingDragged = null
		
func raycastCheckForCard():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	if(result.size() > 0):
		return result[0].collider.get_parent()
	return null
	
func raycastCheckForCardSlot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 2
	var result = space_state.intersect_point(parameters)
	if(result.size() > 0):
		return result[0].collider.get_parent()
	return null

func cardFollowMouse():
	if cardBeingDragged:
		var mouse_pos = get_global_mouse_position()
		var vect = Vector2(clamp(mouse_pos.x, 0, screenSize.x),clamp(mouse_pos.y, 0, screenSize.y))
		cardBeingDragged.global_position = vect
