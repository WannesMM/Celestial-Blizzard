extends CardLayout

class_name GridCardLayout

# Number of cards on X axis
@export var gridSizeX: int = 1
# Number of cards on Y axis
@export var gridSizeY: int = 1
# Whether the grid should scroll (possible values: "horizontal", "vertical", "none")
@export_enum("none", "horizontal", "vertical") var scroll: String = "none"
# Scale all the cards relative to the default card size
@export var scaleCards: float = 1.0
# Outer margins of the grid
@export var outerMargin: float = 0.0
# X Margins between cards (only when scroll is horizontal)
@export var innerMarginX: float = 0.0
# Y Margins between cards (only when scroll is vertical)
@export var innerMarginY: float = 0.0
# The collider associated with the layout
@export var collider: LayoutCollision

func arrangeCards():
	if collider == null:
		printerr("Please select the collider for this layout!")
		return
	
	var colliderSize: Vector2
	var collisionShape: CollisionShape2D = collider.find_child("CollisionShape2D")
	if collisionShape != null:
		colliderSize = collisionShape.shape.size
		self.global_position = collisionShape.global_position
	else:
		printerr("Could not find collision shape belonging to this layout!")
		return
	
	# Apply margins
	colliderSize -= Vector2(outerMargin * 2, outerMargin * 2)
	
	# Return error when the cards do not fit
	if (gridSizeX * gridSizeY < addedCards.size()) && scroll == "none":
		printerr(str(addedCards.size()) + " cards do not fit in a " + str(gridSizeX) + "x" + str(gridSizeY) + " grid!")
		return
	
	if len(addedCards) == 0:
		return
	
	var cardSize = addedCards[0].getSize() * scaleCards
	print("cs=", cardSize)
	# calculate correct widths and starting positions
	var cellWidth = colliderSize.x / gridSizeX
	var cellHeight = colliderSize.y / gridSizeY
	var startX = -colliderSize.x / 2 + cellWidth / 2
	var startY = colliderSize.y / 2 - cellHeight / 2
	var Xitterations = gridSizeX
	var Yitterations = gridSizeY
	
	print(scroll)
	match scroll:
		"horizontal":
			startX  = -colliderSize.x / 2 + cardSize.x / 2 
			cellWidth = cardSize.x + innerMarginX
			Xitterations = ceil(float(len(addedCards))/gridSizeY)
		"vertical":
			startY  = -colliderSize.y / 2 + cardSize.y / 2 
			cellHeight = cardSize.y + innerMarginY
			Yitterations = ceil(float(len(addedCards))/gridSizeX)
	print("loop")
	print(Xitterations,"  ", Yitterations)
	print(len(addedCards))
	# Set the remaining cards
	for y in range(Yitterations):
		for x in range(Xitterations):
			var index = y * gridSizeX + x
			if index >= addedCards.size():
				break
			
			var cardPosition = Vector2(startX + x * cellWidth, startY + y * cellHeight)
			
			var card = addedCards[index]
			card.assignDefaultScale(Vector2(scaleCards,scaleCards))
			card.setBasePosition(cardPosition)
			card.animatePosition(cardPosition, 0.5)
	
	
	# HBox-containergrootte aanpassen
	var box = get_parent()  # Zorg dat de HBoxContainer de directe parent is
	if box is HBoxContainer || box is VBoxContainer:
		var totalWidth =  Xitterations * cellWidth + outerMargin * 2
		var totalHeight = Yitterations * cellHeight + outerMargin * 2
		box.custom_minimum_size = Vector2(totalWidth, totalHeight)
	
	var container: ScrollContainer = box.get_parent()
	if container is ScrollContainer:
		match scroll:
			"horizontal":
				container.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
				container.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
			"vertical":
				container.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
				container.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
