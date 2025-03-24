extends Node3D

@export var dialogueSystem = "res://Scenes/Main/DialogueSystem.tscn"

func startChapter(chapter: String):
	startDialogueSystem(chapter)
	AudioEngine.playAmbience("Wind")
	AudioEngine.playStory("Story1")
	
func startDialogueSystem(chapter):
	var dialogueScene = load(dialogueSystem)
	var dialogueInstance: DialogueSystem = dialogueScene.instantiate()
	add_child(dialogueInstance)
	dialogueInstance.startDialogue(chapter)

func _ready() -> void:
	startChapter("Chapter0")
