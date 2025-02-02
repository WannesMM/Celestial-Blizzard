extends Control

#This class is what manages the cardLayout that are children of the node with this script. By default, this class can be used
#to drag cards around and drag them into different layouts (Whatever layout you create), but it's behaviour can also be modified to
#do other things by extending this class.
class_name LayoutManager

const ANIMATIONSCALE = Vector2(1.19,1.19)
const ANIMATIONDURATION: float = 0.19
const SELECTMOVEMENT = Vector2(0,-25)
const HOLDTRESHHOLD = 0.14

var cardBeingDragged: Card
var selectedCard
var screenSize
var isPressed = false
var holdTimer = 0.0

func _ready():
	screenSize = get_viewport_rect().size
	initializeBattle()
	
func _process(delta: float) -> void:
	cardFollowMouse()
	clickAndHoldLogic(delta)
	
#Records mouseinput and distinguishes between click and hold/let go. Exetuting either startDrag(), finishDrag() or click()
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
				click()
				holdTimer = 0.0
				isPressed = false		

#A helper function of _input that runs every frame to check drag.
func clickAndHoldLogic(delta):
	if isPressed:
		holdTimer += delta
		if holdTimer >= HOLDTRESHHOLD and !(cardBeingDragged):
			startDrag()
			isPressed == false
			holdTimer = 0.0
	
#Initializes the card to be dragged and checks wether the layout allows for card drag.
func startDrag():
	var card = raycastCheckForCard()
	if card and card.getLayout().isMovable():
		cardBeingDragged = card
		
#Finish the drag
func finishDrag():
	var cardSlotFound = raycastCheckForCardSlot()
	if cardSlotFound:
		var layout = cardSlotFound.getRespectiveCardLayout()
		draggedIntoLayout(layout, cardBeingDragged)
	else:
		cardBeingDragged.position = cardBeingDragged.getBasePosition()
	cardBeingDragged = null
	
#When clicked
func click():
	selectCard()

#What happens to a card when it is dragged from one layout to another. This may differ for applications so thats why this is a function.
func draggedIntoLayout(layout, card):
	layout.addCardToLayout(card)
	
#This checks al the collisions with the mouse pointer on layer 1 and returns an array of items collided.
#This is used to check which card should be dragged etc
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
	
#The same but on layer 2 and for cardSlots. These are the spaces where cards can be put inside of (also known as cardLayout)
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

#Executes every frame and lets a card be set to the position of the mouse.
func cardFollowMouse():
	if cardBeingDragged:
		var mouse_pos = get_global_mouse_position()
		var vect = Vector2(clamp(mouse_pos.x, 0, screenSize.x),clamp(mouse_pos.y, 0, screenSize.y))
		cardBeingDragged.global_position = vect

#This selects a card.
func selectCard():
	var card = raycastCheckForCard()
	if card:
		if selectedCard != null:
			undoSelect()
		if card == selectedCard:
			undoSelect()
			closeCardInformation()
			selectedCard = null
		else:
			selectedCard = card
			highlightSelect()
			displayCardInformation()
	else:
		if selectedCard:
			undoSelect()
			closeCardInformation()
			selectedCard = null
	
#This unselects a card
func undoSelect():
	selectedCard.undoHighlightCard()
	selectedCard.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
	selectedCard.moveCardDownSelect()
	
#All the animations for selecting
func highlightSelect():
	selectedCard.highlightCard()
	selectedCard.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
	if(selectedCard.getLayout().allied == true):
		selectedCard.moveCardUpSelect(SELECTMOVEMENT)
	else:
		selectedCard.moveCardUpSelect(-SELECTMOVEMENT)

#For the information slider when selected
func closeCardInformation():
	$"Right Slider".closeCardInformation()

func displayCardInformation():
	$"Right Slider".displayCardInformation(selectedCard)

# BattleManager ------------------------------------------------------------------------------------

#Executes at the start of the battle. This is an abstract function.
func initializeBattle():
	pass
