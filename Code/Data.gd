extends Node

var game: Game = Game.new()

#Data Navigation----------------------------------------------------------------

func getWorldById(id: String):
	for world: World in Data.game.worlds:
		if world.getStaticWorldData().id == id:
			return world
	return null

func getAreaById(world: World, id: String):
	for area: StoryArea in world.areas:
		if area.getStaticAreaData().id == id:
			return area
	return null

func travelToArea(world: String, area: String):
	game.currentWorld = getWorldById(world)
	game.currentWorld.currentStoryArea = getAreaById(game.currentWorld,area)
	Load.callLoadingScreen("res://Scenes/Main/MainScreen.tscn")

#Event System-------------------------------------------------------------------

var currentEvent: StoryEventStatic
var currentEventProgress: int
var eventSequence: EventSequenceStatic
var eventArea: StoryArea

func registerEvent(event: StoryEventStatic, eventArea: StoryArea):
	currentEvent = event
	currentEventProgress = 0
	self.eventArea = eventArea
	eventSequence = load(event.eventSequenceLink)
	
func executeActions():
	var eventAction: EventActionStatic = eventSequence.eventSequence[Data.currentEventProgress]
	
	currentEventProgress = eventAction.nextId
	if currentEventProgress == -1:
		eventArea.endEvent(currentEvent)
		currentEvent = null
		currentEventProgress = 0
		eventSequence = null
		eventArea = null
		print("Event sequence concluded")
		
	return eventAction
	
func isEventActive() -> bool:
	if currentEvent:
		return true
	return false

var showMainScreen: bool = true
