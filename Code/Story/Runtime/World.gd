extends Node

class_name World

var staticWorldDataLink: String

var areas: Array[StoryArea] = []
var activeAreas: Array[StoryArea] = []

var currentStoryArea: StoryArea
var currentChapter: String

func getStaticWorldData() -> WorldStatic:
	return load(staticWorldDataLink)
