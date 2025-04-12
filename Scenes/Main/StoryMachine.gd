extends Node3D

class_name StoryMachine

@export var dialogueSystem = "res://Scenes/Main/DialogueSystem.tscn"

func startChapter(chapter: String):
	$ColorRect.visible = true
	var tween = create_tween().tween_property($ColorRect,"modulate:a",0,3)
	
	startDialogueSystem(chapter)
	AudioEngine.playAmbience("Wind")
	AudioEngine.playStory("Story1")
	
func startDialogueSystem(chapter):
	var dialogueScene = load(dialogueSystem)
	var dialogueInstance: DialogueSystem = dialogueScene.instantiate()
	add_child(dialogueInstance)
	dialogueInstance.startDialogue(chapter)
