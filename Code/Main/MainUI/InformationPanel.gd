extends Control

var layoutManager: LayoutManager = null
var currentCard: Card

const titleScene = preload("res://Scenes/Main/UI components/Title.tscn")
const portraitScene = preload("res://Scenes/Main/UI components/Portrait.tscn")
const buttonScene = preload("res://Scenes/Main/UI components/Button.tscn")
const textScene = preload("res://Scenes/Main/UI components/Text.tscn")
const parameterScene = preload("res://Scenes/Visual/ParameterDisplay.tscn")

func _ready() -> void:
	visible = false
	
func displayCardInformation(card: Card):
	if card != currentCard:
		removeAll()
		currentCard = card
	
	buttonCounter = 1
	for item in card.getDisplayInfo():
		var element = item[0]
		var body = item[1]
		match element:
			"Title":
				createTitle(body)
			"Portrait":
				createPortrait(body)
			"Button":
				createButton(body)
			"Text":
				createText(body)
			"Parameter":
				if item.size() == 5:
					createParameter(item[1], item[2], item[3], item[4])
				else:
					createParameter(item[1], item[2], item[3])
	visible = true

func removeAll():
	for element in $Scroll/VBoxContainer.get_children():
		$Scroll/VBoxContainer.remove_child(element)
		element.queue_free()

func createTitle(newText: String):
	var title = titleScene.instantiate()
	title.text = newText
	$Scroll/VBoxContainer.add_child(title)
	
func createPortrait(portrait: Texture):
	var scene = portraitScene.instantiate()
	scene.setTexture(portrait)
	$Scroll/VBoxContainer.add_child(scene)

var buttonCounter := 1

func createButton(newText: String):
	var scene = buttonScene.instantiate()
	scene.text = newText
	
	match buttonCounter:
		1:
			scene.callbackFunction = NAbuttonPressed
		2:
			scene.callbackFunction = SAbuttonPressed
		3:
			scene.callbackFunction = CAbuttonPressed
	
	buttonCounter += 1
	$Scroll/VBoxContainer.add_child(scene)
	
func createText(newText: String):
	var scene = textScene.instantiate()
	scene.text = newText
	$Scroll/VBoxContainer.add_child(scene)
	
func createParameter(newValue: int, newMin: int, newMax: int, newColor = Color.MAROON):
	var scene = parameterScene.instantiate()
	$Scroll/VBoxContainer.add_child(scene)
	scene.initialise(newValue, newMin, newMax, newColor)
	
func closeCardInformation():
	visible = false
	removeAll()

func NAbuttonPressed() -> void:
	layoutManager.characterCardMove("NA", currentCard)

func SAbuttonPressed() -> void:
	layoutManager.characterCardMove("SA", currentCard)

func CAbuttonPressed() -> void:
	layoutManager.characterCardMove("CA", currentCard)
