extends Control

class_name DialogueSystem

func setDialogue(dialogue: String, characterName: String):
	setName(characterName)
	setTextBox(dialogue)
	
func setTextBox(dialogue: String):
	$TextBox.setDisplayText(dialogue)
	$TextBox.fadeIn(7)
	
func setName(characterName: String):
	$CharacterName.setDisplayText(characterName)
	$CharacterName.fadeIn()

func next() -> void:
	GlobalSignals.eventActionComplete.emit()
