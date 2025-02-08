extends Node2D

class_name Card

var DEFAULTSCALE = null
const ACTIVECHARMOVEMENT = Vector2(0,-25)
const ANIMATIONSCALE = Vector2(1.19,1.19)
const ANIMATIONDURATION: float = 0.19
var defaultZIndex = self.z_index

var scaleTween: Tween = null
var currentlyAnimating = false
var currentlySelected = false

var movementTween

var collision: LayoutCollision

signal cardMouseEntered
signal cardMouseExited

#The CardLayout that this card is part of at the moment.
var currentLayout: CardLayout

func _ready() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	self.global_position = Vector2(viewport_size.x / 2, viewport_size.y / 2)
	DEFAULTSCALE = self.scale
	
func assignDefaultScale(scaled: Vector2):
	DEFAULTSCALE = scaled
	self.scale = scaled
	
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

func scaleRelative(target_ratio, duration = ANIMATIONDURATION):
	
	var scaler = DEFAULTSCALE.x * target_ratio.x
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
	print(currentlyAnimating)
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
	
#DEZE IS HET PROBLEEM
func moveCardDownSelect(duration: float = ANIMATIONDURATION):
	currentlySelected = false
	resetZIndex()
	stopMovementTween()
	movementTween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	movementTween.tween_property(self, "position", basePosition, duration)
	await movementTween.finished
	
func animatePosition(pos: Vector2, duration: float = ANIMATIONDURATION):
	stopMovementTween()
	movementTween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	movementTween.tween_property(self, "position", pos, duration)
	await movementTween.finished
	
func animateGlobalPosition(pos: Vector2, duration: float = ANIMATIONDURATION):
	stopMovementTween()
	movementTween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	movementTween.tween_property(self, "global_position", pos, duration)
	await movementTween.finished
	
func stopMovementTween():
	if movementTween and movementTween.is_running():
		movementTween.kill()
	
func setLayout(layout):
	currentLayout = layout
	
func getLayout():
	return currentLayout
	
func increaseZIndex():
	self.z_index = 1
	
func resetZIndex():
	if !currentlySelected:
		self.z_index = defaultZIndex

#---------------------------------------------------------------------------------------------------------------------

var cardLogic: CardLogic = null

func setCard(card: CardLogic):
	cardLogic = card
	loadCardImage()
	generateShaderColor()
	cardLogic.setCard(self)
	
func getCardLogic():
	return cardLogic
	
func loadCardImage():
	var imagePath = "res://assets/Cards/" + cardLogic.getCardType() + "/" + cardLogic.getImageLink() + ".png"
	
	var texture = ResourceLoader.load(imagePath)
	if texture and texture is Texture2D:
		$cardImage.texture = texture
	else:
		print("card Image does not exist:")
		print(cardLogic.getCardType())
		print(cardLogic.getImageLink())
		$cardImage.texture = ResourceLoader.load("res://assets/Cards/CharacterCard/cardNotFound.png")

func generateShaderColor():
	var texture = $cardImage.texture
	
	var image_width = texture.get_width()
	var image_height = texture.get_height()
	var sample_color = texture.get_image().get_pixel(image_width / 2, image_height / 2)
	
	$CardBorder.modulate = sample_color
	#$CardBorder/CardShader.self_modulate = sample_color

func setActive(x: bool):
	if x:
		moveCardUpSelect(ACTIVECHARMOVEMENT)
	else:
		moveCardDownSelect()
