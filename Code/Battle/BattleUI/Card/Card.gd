extends Node2D

class_name Card

const ACTIVECHARMOVEMENT = Vector2(0,-25)
const ANIMATIONSCALE = Vector2(1.19,1.19)
const ANIMATIONDURATION: float = 0.19
var defaultZIndex = self.z_index

var scaleTween: Tween = null
var currentlyAnimating = false
var currentlySelected = false

var movementTween

var collision: LayoutCollision
var relatedCards: Array[Card] = []

signal cardMouseEntered
signal cardMouseExited

#The CardLayout that this card is part of at the moment.
var currentLayout: CardLayout
	
func cardConstructor():
	pass
	
func _on_area_2d_mouse_entered() -> void:
	emit_signal("cardMouseEntered", self)
	
func _on_area_2d_mouse_exited() -> void:
	emit_signal("cardMouseExited", self)

func highlightCard():
	increaseZIndex()
	$Highlight.mouseEntered()
	
func undoHighlightCard():
	resetZIndex()
	$Highlight.mouseExited()

func flashCard():
	highlightCard()
	await Random.wait(1)
	undoHighlightCard()

func highlightBorder():
	$CardBorderHighlight.fade(1, 0.5)
	
func undoHighlightBorder():
	$CardBorderHighlight.fade(0, 0.5)

func highlightOuterGlow():
	$CardOutsideShade.fade(1, 0.5)
	
func undoHighlightOuterGlow():
	$CardOutsideShade.fade(0, 0.5)

func scaleRelative(target_ratio, duration = ANIMATIONDURATION):
	var scaler = target_ratio.x
	scaleTo(Vector2(scaler, scaler), duration)

func scaleTo(target_scale: Vector2, duration: float = ANIMATIONDURATION):
	
	if scaleTween:
		scaleTween.kill
	scaleTween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	scaleTween.tween_property(self, "scale", target_scale, duration)
	
func moveRelativeAnimation(vector: Vector2, duration: float = ANIMATIONDURATION):
	
	while(currentlyAnimating):
		await IsAnimating
	
	toggleIsAnimating(true)
	var targetPosition = self.position + vector
	
	stopMovementTween()
	var movementTween: Tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	movementTween.tween_property(self, "position", targetPosition, duration)
	await movementTween.finished

	toggleIsAnimating(false)
	
signal IsAnimating

func toggleIsAnimating(animating: bool):
	currentlyAnimating = animating
	emit_signal("IsAnimating")

var basePosition = Vector2(0,0)

func setBasePosition(pos: Vector2):
	basePosition = pos

func getBasePosition():
	return basePosition

func moveCardUpSelect(vector: Vector2, duration: float = ANIMATIONDURATION):
	if(getLayout().allied == true):
		vector = vector
	else:
		vector = -vector
	currentlySelected = true
	increaseZIndex()
	var targetPosition = basePosition + vector
	stopMovementTween()
	movementTween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	movementTween.tween_property(self, "position", targetPosition, duration)
	await movementTween.finished
	
func moveCardDownSelect(duration: float = ANIMATIONDURATION):
	currentlySelected = false
	resetZIndex()
	stopMovementTween()
	movementTween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	movementTween.tween_property(self, "position", basePosition, duration)
	await movementTween.finished
	
func animatePosition(pos: Vector2, duration: float = ANIMATIONDURATION):
	stopMovementTween()
	movementTween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	movementTween.tween_property(self, "position", pos, duration)
	await movementTween.finished
	
func animateGlobalPosition(pos: Vector2, duration: float = ANIMATIONDURATION):
	stopMovementTween()
	movementTween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	movementTween.tween_property(self, "global_position", pos, duration)
	await movementTween.finished
	
func stopMovementTween():
	if movementTween and movementTween.is_running():
		movementTween.kill()
	
func setLayout(layout):
	currentLayout = layout
	
func getLayout() -> CardLayout:
	return currentLayout
	
func increaseZIndex():
	self.z_index = 1
	
func resetZIndex():
	if !currentlySelected:
		self.z_index = defaultZIndex
		
func collision1and2():
	$CardPlacementCollision/Area2D.collision_layer = (1 << 0) | (1 << 1)

func collision1():
	$CardPlacementCollision/Area2D.collision_layer = 1 << 0

func playSwitchAnimation():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("CharacterSwitch")

func stopSwitchAnimation():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.stop()

#Manages the card shatter effect stage 0 = invisible, stage 1 = fase 1 shatter ... until stage 4, which is defeated
func cardShatterStage(stage: int):
	if stage >= 1:
		$CardShatter.visible = true
		$CardShatter.frame = stage - 1
	if stage == 4:
		$Darken.modulate.a = 0
		$Darken.visible = true
		var fadeTween = create_tween()
		fadeTween.tween_property($Darken,"modulate:a",0.4,1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)

func darkenCard(cards: Array[Card]):
	if (self in cards) == false:
		$Darken.modulate.a = 0
		$Darken.visible = true
		var fadeTween = create_tween()
		fadeTween.tween_property($Darken,"modulate:a",0.4,1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)

func undoDarkenCard():
	$Darken.modulate.a = 0.4
	$Darken.visible = true
	var fadeTween = create_tween()
	fadeTween.tween_property($Darken,"modulate:a",0,1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)

#---------------------------------------------------------------------------------------------------------------------

var cardImage: Texture

func setCardImage(image: String):
	imageLink = image
	
	var imagePath = "res://assets/Cards/" + cardType + "/" + imageLink + ".png"
	
	ResourceLoader.load_threaded_request(imagePath)
	
	while ResourceLoader.load_threaded_get_status(imagePath) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await Random.wait(0.01)
	
	var texture = ResourceLoader.load_threaded_get(imagePath)
	
	if texture and texture is Texture2D:
		$CardMask/cardImage.setImage(texture, imagePosition, imageScale)
		cardImage = texture
	else:
		print("card Image does not exist:")
		print(cardType)
		print(imageLink)
		$CardMask/cardImage.texture = ResourceLoader.load("res://assets/Cards/CharacterCard/cardNotFound.png")
		
	generateShaderColor()

func generateShaderColor():
	$CardBorder.modulate = sampleColor
	$CardBorder/CardShader.modulate = sampleColor
	$CardInsideShade.modulate = sampleColor
	
	$CardOutsideShade.fade(0)

func addRelatedCard(card: Card):
	relatedCards.append(card)
	if currentLayout:
		currentLayout.addAdditionalCard(card)
		assert(currentLayout.additionalCards.size() != 0)
	
func removeRelatedCard(card: Card):
	relatedCards.erase(card)

func setLabel1(text: String):
	$Label.text = text

func setLabel1Color(color: Color):
	$Label.modulate = color

const iconPath = "res://Scenes/Visual/Icon.tscn"

func addEffect(effect: Effect):
	appliedEffects.append(effect)
	
	var iconScene = load(iconPath)
	var icon: Icon = iconScene.instantiate()
	icon.setIcon(effect.image)
	icon.setUses(str(effect.stacks))
	icon.representative = effect
	$IconDisplay.addIcon(icon)

func removeEffect(effect: Effect):
	appliedEffects.erase(effect)
	gameState.scheduledEffects.erase(effect)
	
	for icon: Icon in $IconDisplay.icons:
		if icon.representative == effect:
			$IconDisplay.removeIcon(icon)

# CardLogic --------------------------------------------------------------------

var card: Card = self

var cardName: String = "Name Unknown"
var cardType: String = "Type Unknown"
var cardCost: int = 1: set = setCost

# Card image settings
var imageLink: String = "Card Unknown": set = setCardImage
var imagePosition: Vector2 = Vector2(0,0)
var imageScale: Vector2 = Vector2(1,1)
var sampleColor: Color

var cardOwner: PlayerState = null
var gameState: GameState = null

var appliedEffects: Array[Effect] = []

var damageBonus: int = 0

# Gamefunctionality ------------------------------------------------------------

var targetable: bool = true

# Code that triggers when the card is played, to be extended
func playCard():
	playCardLogic()
	
func playCardLogic():
	Random.message("This card has not been implemented")

# This returns the layouts that this card is playable on
func playableOn():
	pass

func checkCost(req: int):
	if req > cardOwner.battleResources.gold:
		cardOwner.gameState.layoutManager.message("Not enough Gold")
		return false
	else:
		return true

#This is extended in Bartholomew
func attack(dmg: int):
	await cardOwner.damage(self, dmg + damageBonus)
	
func removeAllEffects():
	for effect in appliedEffects:
		removeEffect(effect)

func getDisplayInfo():
	return [
["Title", cardName],
["Portrait", cardImage],
["Text", getCardDescription()]
]

func setCost(newCost: int):
	cardCost = newCost
	setLabel1(str(cardCost))

# Getters and Setters ----------------------------------------------------------

func getCardName():
	return cardName
	
func getCardType():
	return cardType

func getImageLink():
	return imageLink

func getCard():
	return card

func getCardCost():
	return cardCost
	
func setCardCost(cost):
	cardCost = cost

func setCardOwner(player: PlayerState):
	cardOwner = player
	
func getCardOwner(player: PlayerState):
	return cardOwner
	
func getCardDescription():
	return "This is the default description."
