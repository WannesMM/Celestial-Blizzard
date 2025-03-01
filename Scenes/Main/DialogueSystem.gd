extends Control

class_name DialogueSystem

var currentID: int = 1
var currentLine: Dictionary

func proceed():
	AudioEngine.playSFX("TextProceed")
	nextDialogue()

func startDialogue(chapter: String):
	var fadeTween = create_tween()
	fadeTween.tween_property(self,"modulate:a",1,0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await fadeTween.finished
	fadeTween.kill()
	
	loadDialogue(chapter)
	currentLine = dialogueData[0]
	currentID = 1
	setDialogue(currentLine.get("text"), currentLine.get("name"))

func endDialogue():
	var fadeTween = create_tween()
	fadeTween.tween_property(self,"modulate:a",0,0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await fadeTween.finished
	fadeTween.kill()
	queue_free()

var choice: int
var playerName: String

func nextDialogue():
	if currentLine.get("type") == "Choice":
		currentID = currentLine.get("nextID")[choice]
	else:
		currentID = currentLine.get("nextID")
	if currentID != -1:
		currentLine = dialogueData[currentID - 1]
		match currentLine.get("type"):
			"Normal":
				setDialogue(currentLine.get("text"), currentLine.get("name"))
			"Choice":
				choice = await Random.choiceMessage("What will you say?", currentLine.get("text"))
				setDialogue(currentLine.get("text")[choice], "You")
			"TextInput":
				name = await Random.textInputMessage(currentLine.get("text")[0])
				setDialogue(currentLine.get("text")[0] + name + ".", currentLine.get("name"))
			"Var":
				setDialogue(replaceWithVar(currentLine.get("text")), currentLine.get("name"))
	else:
		endDialogue()
	
func replaceWithVar(arr):
	var result = ""
	for string in arr:
		match string:
			"Name":
				result += name
			_:
				result += string
	return result

func setDialogue(dialogue: String, name: String):
	setName(name)
	setTextBox(dialogue)
	setPortrait(name)
	
func setPortrait(name: String):
	var link: String = ""
	var pos: Vector2
	var scalar: Vector2
	match name:
		"Hatsune Miku":
			link = "res://assets/Cards/CharacterCard/Hatsune Miku.png"
			pos = Vector2(151.674,147.432)
			scalar = Vector2(0.12,0.12)
		"Shadowy figure":
			link = "res://assets/Story/Shadowy Figure.jpeg"
			pos = Vector2(167.774,165.8)
			scalar = Vector2(0.54,0.54)
		"You":
			link = "res://assets/Story/You.jpeg"
			pos = Vector2(94.807,116.904)
			scalar = Vector2(0.415,0.415)	
	$DialogueContainer/PortraitBox/PortraitAnchor/PortraitScaler/PortraitMask/PortraitSprite.setPortraitImage(link, pos, scalar)
			
func setTextBox(dialogue: String):
	$DialogueContainer/TextContainer/TextBox.setText(dialogue)
	
func setName(name: String):
	$DialogueContainer/TextContainer/CharacterName.setText(name)

# DialogueManager --------------------------------------------------------------

@export var filePath: String = "res://File/Dialogue.json"

var dialogueData = {}

func _ready() -> void:
	modulate.a = 0

func loadDialogue(part: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath,FileAccess.READ)
		var parsedResult: Dictionary = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			dialogueData = parsedResult.get(part)
		else:
			Random.message("ERROR: Dialogue was not in the proper format")
	else:
		Random.message("ERROR: Failed to load Dialogue")
