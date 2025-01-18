extends Node2D

# Constants for card size in pixels (A4 vertical size in your game) 210
var ARRAY_WIDTH = 700
var CENTER_Y = 150
var CENTER_X = 0
var CARD_SCALE = 1
var ADDEDCARDS = []

var cardBeingDragged
var screenSize

func _ready():
	screenSize = get_viewport_rect().size
	assignConstants()
	addInitialCards()
	arrange_cards()
	
func _process(delta: float) -> void:
	cardFollowMouse()
	
	
func assignConstants():
	ARRAY_WIDTH = ARRAY_WIDTH
	CENTER_Y = CENTER_Y
	CENTER_X = CENTER_X
	CARD_SCALE = CARD_SCALE
	
func connectSignal(card):
	if card.has_signal("cardMouseEntered"):
		card.connect("cardMouseEntered", Callable(self, "cardMouseEntered"))
	if card.has_signal("cardMouseExited"):
		card.connect("cardMouseExited", Callable(self, "cardMouseExited"))
	
func cardMouseEntered(card):
	#card.moveCardUpSelect(Vector2(0,-25))
	pass
	
func cardMouseExited(card):
	#card.moveCardDownSelect()
	pass
	
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

func addCard():
	var cardScene = load("res://Scenes/card.tscn")
	
	if cardScene is PackedScene:  # Ensure it is a PackedScene
		var newCard = cardScene.instantiate()  # Create an instance of the card scene
		
		newCard.assignDefaultScale(Vector2(CARD_SCALE,CARD_SCALE))
		connectSignal(newCard)
		
		add_child(newCard)  # Add the new card to the parent node
		ADDEDCARDS.append(newCard)
		
		arrange_cards()  # Optionally call your arrange function to reposition cards
	else:
		print("Failed to load the card scene!")
	
func addInitialCards():
	addCard()
	addCard()
	addCard()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed: 
			var card = raycastCheckForCard()
			if card:
				cardBeingDragged = card
		else:
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

func cardFollowMouse():
	if cardBeingDragged:
		var mouse_pos = get_global_mouse_position()
		cardBeingDragged.position = Vector2(clamp(mouse_pos.x, 0, screenSize.x),clamp(mouse_pos.y, 0, screenSize.y))
	
