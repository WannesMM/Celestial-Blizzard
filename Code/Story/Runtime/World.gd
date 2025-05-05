extends Node

class_name World

var staticWorldData: WorldStatic

var areas: Array[StoryArea] = []
var activeAreas: Array[StoryArea] = []

var currentStoryAreaId: String
var currentChapter: String
