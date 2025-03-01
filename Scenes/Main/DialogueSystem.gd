extends Control

var currentDialogue: String = "Intro1"

func proceed():
	setDialogue("The screen fades in from black. Snowflakes drift in slow motion before reality snaps into focus. The blizzard rages, icy winds biting deep. The Main Character wakes, breath hitching, breath visible in the cold.", "Shadowy Figure")

func displayNextDialogue():
	pass

func setDialogue(dialogue: String, name: String):
	setName(name)
	setTextBox(dialogue)
	setPortrait(name)

func setPortraitImage(image:String, pos: Vector2, scalar: Vector2):
	$PortraitBox/PortraitAnchor/PortraitScaler/PortraitMask/PortraitSprite.texture = load(image)
	$PortraitBox/PortraitAnchor/PortraitScaler/PortraitMask/PortraitSprite.position = pos
	$PortraitBox/PortraitAnchor/PortraitScaler/PortraitMask/PortraitSprite.scale = scalar
	
func setPortrait(name: String):
	match name:
		"Hatsune Miku":
			setPortraitImage("res://assets/Cards/CharacterCard/Hatsune Miku.png", Vector2(151.674,147.432), Vector2(0.12,0.12))
		"Shadowy Figure":
			setPortraitImage("res://assets/Story/Shadowy figure.jpeg", Vector2(78.257,97.346), Vector2(1.075,1.075))
			
func setTextBox(dialogue: String):
	$TextContainer/TextBox.setText(dialogue)
	
func setName(name: String):
	$TextContainer/CharacterName.setText(name)

# DialogueManager --------------------------------------------------------------

@export var dialogue_file: String = "res://File/Dialogue.json"

var dialogue_data = {}
var current_dialogue = {}

signal dialogue_started(dialogue_text: String, speaker: String, choices: Array)
signal dialogue_ended

func _ready():
	loadDialogueData()

func loadDialogueData():
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	if file:
		dialogue_data = JSON.parse_string(file.get_as_text())

func startDialogue(dialogue_id: String):
	current_dialogue = getDialogueById(dialogue_id)
	if current_dialogue:
		emit_signal("dialogue_started", current_dialogue["text"], current_dialogue.get("speaker", ""), current_dialogue.get("choices", []))

func getDialogueById(dialogue_id: String):
	for dialogue in dialogue_data:
		if dialogue["id"] == dialogue_id:
			return dialogue
	return null

func progressDialogue(next_id: String):
	if next_id:
		startDialogue(next_id)
	else:
		emit_signal("dialogue_ended")
