extends Node

class_name World

var staticWorldData: WorldStatic

var areas: Array[StoryArea] = []
var activeAreas: Array[StoryArea] = []

var currentStoryArea: StoryArea
var currentChapter: String
