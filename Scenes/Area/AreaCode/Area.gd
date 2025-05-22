extends Node3D

class_name Area

@export var worldId: String
@export var areaId: String

@export var environement: Env
@export var camera: Camera3d
var storyArea: StoryArea

var dialogueSystem: DialogueSystem

func _ready() -> void:
	var scene: PackedScene = load("res://Scenes/Main/AbstractDialogueSystem.tscn")
	dialogueSystem = scene.instantiate()
	add_child(dialogueSystem)
	dialogueSystem.visible = false
	camera.shimmerIdle()

# EventSystem ------------------------------------------------------------------

func triggerEvents():
	storyArea.amtVisited += 1
	
	if !Data.isEventActive():
		triggerAutoEvents()
	
	continueEvent()
	
	camera.shimmerIdle()

func triggerAutoEvents():
	for event: StoryEventStatic in storyArea.activeEvents:
		if event.type == 1:
			Data.registerEvent(event, storyArea)
			return

func executeAction():
	var eventAction: EventActionStatic = Data.executeActions()
	if eventAction is EventActionCutscene:
		Load.callLoadingScreen(eventAction.cutsceneLink)
	elif eventAction is EventActionDialogue:
		dialogueSystem.visible = true
		dialogueSystem.setDialogue(eventAction.dialogue,eventAction.characterName)
		
func continueEvent():
	while Data.isEventActive():
		executeAction()
		await GlobalSignals.eventActionComplete
		dialogueSystem.visible = false
	
# Music ------------------------------------------------------------------------

@export var audioTracks: Array[AudioTrack]

func playMusic():
	for audioTrack: AudioTrack in audioTracks:
		AudioEngine.playTrack(audioTrack)
