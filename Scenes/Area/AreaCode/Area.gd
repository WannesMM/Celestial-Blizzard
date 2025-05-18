extends Node3D

class_name Area

@export var worldId: String
@export var areaId: String

@export var environement: Env
@export var camera: Camera3d
var storyArea: StoryArea

func triggerEvents():
	storyArea.amtVisited += 1
	
	triggerAutoEvents()
	
	camera.shimmerIdle()

func triggerAutoEvents():
	for event: StoryEventStatic in storyArea.activeEvents:
		if event.type == 1:
			UserInfo.startEvent(event)
			return
	
