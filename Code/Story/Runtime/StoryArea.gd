extends Node

class_name StoryArea

var staticAreaDataLink: String

#Events ------------------------------------------------------------------------

var events: Array = []
var activeEvents: Array = []
var completedEvents: Array = []

#Area---------------------------------------------------------------------------

var amtVisited: int

func getStaticAreaData() -> AreaStatic:
	return load(staticAreaDataLink)

func endEvent(event: StoryEventStatic):
	if event in activeEvents:
		activeEvents.erase(event)
		completedEvents.append(event)
	else:
		push_error("Tried to end an event but it was not active for this area")
