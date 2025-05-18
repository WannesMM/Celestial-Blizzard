extends Node

class_name StoryEvent

var staticStoryEventDataLink: String

func getStaticStoryEventData() -> StoryEventStatic:
	return load(staticStoryEventDataLink)
