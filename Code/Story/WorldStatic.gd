extends Resource

class_name WorldStatic

@export var id: String = resource_path.get_basename().get_file()

@export var name: String
@export var areas: Array[AreaStatic] = []
