extends Control

const ANIMATIONSCALE = Vector2(1.19,1.19)
const ANIMATIONDURATION: float = 0.19
const SELECTMOVEMENT = Vector2(0,-25)
const HOLDTRESHHOLD = 0.15

var cardBeingDragged
var selectedCard
var screenSize
var isPressed = false
var holdTimer = 0.0

func _ready():
	screenSize = get_viewport_rect().size
	
func _process(delta: float) -> void:
	cardFollowMouse()
	clickAndHoldLogic(delta)
	
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
				selectCard()
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
	if card and (card in ADDEDCARDS):
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

func selectCard():
	pass

#func selectCard():
	#var card = raycastCheckForCard()
	#var previousSelected = selectedCard
	#if card and (card in ADDEDCARDS):
		#selectedCard = card
		#highlightSelected(previousSelected)
		#displayCardInformation()
	#
#func undoSelect():
	#selectedCard.undoHighlightCard()
	#selectedCard.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
	#selectedCard.moveCardDownSelect()
	#
	#
#func highlightSelected(previousSelected):
	#selectedCard.highlightCard()
	#selectedCard.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
	#selectedCard.moveCardUpSelect(SELECTMOVEMENT)
	#if previousSelected and (previousSelected != selectedCard):
		#previousSelected.undoHighlightCard()
		#previousSelected.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
		#previousSelected.moveCardDownSelect()
#
#func displayCardInformation():
	#pass
