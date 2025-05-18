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
