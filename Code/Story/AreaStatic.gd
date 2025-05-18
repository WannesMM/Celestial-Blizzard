extends Resource

class_name AreaStatic

@export var id: String = resource_path.get_basename().get_file()

@export var name: String
@export var environment: String
@export var storyEvents: Array[StoryEventStatic] = []
