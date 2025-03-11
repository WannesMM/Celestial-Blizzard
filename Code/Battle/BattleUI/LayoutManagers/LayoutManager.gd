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
var screenSize
var isPressed = false
var holdTimer = 0.0

var selectedCards = []

#LayoutSettings
var multiselect: int = 1
var deselectWhenClickEmpty = true

func _ready():
	screenSize = get_viewport_rect().size
	layoutManagerConstructor()
	
# Called at ready, to be extended
func layoutManagerConstructor():
	pass
	
func _process(delta: float) -> void:
	cardFollowMouse(delta)
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
		startCardDrag(cardBeingDragged)

#Function called when a card starts being dragged
func startCardDrag(card: Card):
	pass

#Finish the drag
func finishDrag():
	var cardSlotFound = raycastCheckForCardSlot()
	finishCardDrag(cardBeingDragged)
	if cardSlotFound:
		var layout = cardSlotFound.getRespectiveCardLayout()
		if cardSlotFound is CardCollision:
			layout = cardSlotFound.cardScene
		draggedIntoLayout(layout, cardBeingDragged)
	else:
		cardBeingDragged.animatePosition(cardBeingDragged.getBasePosition(), 0.7)
	cardBeingDragged = null

#Function called when the card is stopped dragging
func finishCardDrag(card: Card):
	pass

#When clicked
func click():
	var card = raycastCheckForCard()
	if card:
		if card.getLayout().isClickable():
			clickOnCard(card)
	else:
		clickEmpty()

func clickOnCard(card: Card):
	card.getLayout().onClick(card)
	if selectedCards.size() == 1:
		if card.currentLayout is CharacterCardLayout and card == selectedCards[0]:
			characterCardSwitch(card)
	if card.getLayout().getSelectable():
		selectCard(card)

func characterCardSwitch(card):
	pass

func clickEmpty():
	if deselectWhenClickEmpty:
		deselectAllCards()

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
		return result[0].collider.get_parent().cardScene
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
func cardFollowMouse(delta):
	if cardBeingDragged:
		var mouse_pos = get_global_mouse_position()
		var vect = Vector2(clamp(mouse_pos.x, 0, screenSize.x),clamp(mouse_pos.y, 0, screenSize.y))
		cardBeingDragged.global_position = cardBeingDragged.global_position.lerp(get_global_mouse_position(), 10 * delta)
		#cardBeingDragged.global_position = vect

#This selects a card.
func selectCard(card: Card):
	if card in selectedCards:
		undoSelect(card)
		closeCardInformation()
	elif selectedCards.size() >= multiselect:
		undoSelect(selectedCards[0])
		highlightSelect(card)
		displayCardInformation(card)
	else:
		highlightSelect(card)
		displayCardInformation(card)
	
func deselectAllCards():
	var i = 0
	var len = selectedCards.size()
	while i < len:
		undoSelect(selectedCards[0])
		i = i + 1
	closeCardInformation()
	assert(selectedCards == [])
	
#This unselects a card
func undoSelect(card):
	if(card.get_tree() != null):
		card.undoHighlightCard()
		card.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
		if card.getLayout().CARD_LAYOUT_TYPE != "CharacterCardLayout":
			card.moveCardDownSelect()
	selectedCards.erase(card)
	if card.currentLayout is CharacterCardLayout:
		card.stopSwitchAnimation()
	
#All the animations for selecting
func highlightSelect(card):
	if card.getLayout().CARD_LAYOUT_TYPE == "CharacterCardLayout":
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
	else:
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
		card.moveCardUpSelect(SELECTMOVEMENT)
	selectedCards.append(card)

#For the information slider when selected
func closeCardInformation():
	$"Right Slider".closeCardInformation()

func displayCardInformation(card: Card):
	if card.getLayout().getShowInformation():
		$"Right Slider".displayCardInformation(card)
	if card.currentLayout is CharacterCardLayout and !card.active:
		card.playSwitchAnimation()

func setMultiselect(x):
	deselectAllCards()
	multiselect = x
	
func getSelected():
	return selectedCards
	
func setDeselectWhenClickEmpty(x):
	deselectWhenClickEmpty = x
	
func wait(time: float):
	await get_tree().create_timer(time).timeout
	
# BattleManager ------------------------------------------------------------------------------------

#Executes at the start of the battle. This is an abstract function.
func initializeBattle():
	pass

func highlightCollider(layout):
	pass

func undoHighlightCollider(layout):
	pass
