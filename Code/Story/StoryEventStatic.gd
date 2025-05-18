extends Resource

class_name StoryEventStatic

enum EventType {Manual, Auto}

@export var type: EventType
@export var id: String = resource_path.get_basename().get_file()
@export var eventSequenceLink: String
